# -*- coding: utf-8 -*-
require "zlib"
require "open-uri"
require "nokogiri"
require "omakasepng/version"

module Omakasepng
  extend self
  
  VIVID_COLOR = {
    cyan: [0,255,255],
    magenta: [255,0,255],
    yellow: [255,255,0],
    green: [0,255,0],
    red: [255,0,0],
    blue: [0,0,255]
  }
  
  class Generator
    def initialize(opts={})
      @url = "http://ja.wikipedia.org/wiki/%E7%89%B9%E5%88%A5:%E3%81%8A%E3%81%BE%E3%81%8B%E3%81%9B%E8%A1%A8%E7%A4%BA"

      doc = Nokogiri::HTML(open(@url))
      @text = doc.css( "//body").inner_text
      @title = doc.css( "//title").inner_text

      @width = @height = opts[:size] || 640
      @depth = opts[:depth] || 8 
      @color_type = opts[:color_type] || 2
      @out_path = opts[:out_path] || File.dirname(__FILE__)+'/../pngout'
      # 該当ないとランダム
      @color_bar = VIVID_COLOR[opts[:color_bar]] || :random
    end

    def title
      @title
    end

    def txt2rgb
      @text.gsub(/[\t\n\r]/,"")
        .scan(/./).map!{ |x| x.ord.to_s(16)}
        .join
        .scan(/....../).map { |e| e.scan(/../).map { |e2| e2.hex } }
    end


    def raw_data
      border_line = (@height/4).to_i
      body_line = @height - border_line
      
      # rgbの配列
      rgb_ary = txt2rgb
      
      # 指定サイズに足りない分を水増し、切り捨て
      if rgb_ary.size < body_line*@width 
        _body = rgb_ary * (1.0*body_line*@width/rgb_ary.size).ceil
        body = _body[0..body_line*@width]
      else
        body = rgb_ary[0..body_line*@width]
      end

      # 原色ボーダー
      vc = @color_bar == :random ? VIVID_COLOR.values.sample : @color_bar
      border = (0...@width).map { |e| vc }

      # ボーダーとおまかせwikipedia
      [border]*border_line + slice_array(body, @width)
    end
    

    # every毎で配列をスライス、余りは破棄
    def slice_array(ary, every)
      ret = []
      while ary.size > every
        ret << ary.slice!(0..every-1)
      end
      ret
    end


    # チャンクのバイト列生成関数
    def chunk(type, data)
      [data.bytesize, type, data, Zlib.crc32(type + data)].pack("NA4A*N")
    end


    def export
      path = File.expand_path(File.join @out_path, "#{@title.sub(' - Wikipedia','').gsub(/[\/\s]+/,'')}.png")
      open(path, "wb") do |png|
        # ファイルシグニチャ
        png.write "\x89PNG\r\n\x1a\n"

        # ヘッダ
        png.write chunk("IHDR", [@width, @height, @depth, @color_type, 0, 0, 0].pack("NNCCCCC"))

        # 画像データ
        # TODO: 設定サイズに対して肥大する箇所
        img_data = raw_data.map {|line| ([0] + line.flatten).pack("C*") }.join
        png.write chunk("IDAT", Zlib::Deflate.deflate(img_data))

        # 終端
        png.write chunk("IEND", "")
      end

      yield path if block_given?
      puts "==> #{path}"
    end
  end
  
end
