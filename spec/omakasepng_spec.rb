# -*- coding:  utf-8 -*-
require 'spec_helper'

describe Omakasepng::Generator do
  
  opts = {
    size: 128,
  }    
  let(:oma){ Omakasepng::Generator.new(opts) }
  let(:size) { opts[:size] || 960 }
      
  
  describe "txt2rgb" do
    context "wikipediaのおまかせページの文字列をRGBの配列にする" do
      it "文字列はrgbの配列になる" do
        oma.txt2rgb.class.should eq Array
      end

      it "各配列数は3" do
        oma.txt2rgb.first.size.should eq 3
      end
    
      it "各配列の値は255以下" do
        oma.txt2rgb.first[0].should <= 255
        oma.txt2rgb.first[1].should <= 255
        oma.txt2rgb.first[2].should <= 255
      end
    end

  end
  
  
  describe "raw_data" do
    context "設定したピクセル数分のRGBの配列" do
      it "raw_dataは配列" do
        oma.raw_data.class.should eq Array
      end
    
      it "raw_dataの最初は原色" do
        Omakasepng::VIVID_COLOR.values.include?(oma.raw_data.first.first).should be_true
      end
      
      it "raw_dataの数は指定画像サイズと同じ" do
        oma.raw_data.size.should eq size
      end
    end
    
  end
  
  
  describe "title" do
    context "wikipediaのタイトル" do
      it "タイトルはwikipediaを含む" do
        oma.title.should =~ /.+\ \-\ Wikipedia$/
      end
    end
  end
    
  
  describe "export" do

    context "書出し" do
      it "タイトルとファイル名が一部一致" do
      omakase = double("omakase", 
        url: "http://ja.wikipedia.org/wiki/%E3%81%A0%E3%82%93%E3%81%94%E3%82%80%E3%81%97",
        text: "だんごだんごだんご　だんごむし",
        title: "ダンゴムシ - Wikipedia",
        width: 128,
        height: 128,
        depth: 8,
        color_type: 2,
        out_path: File.dirname(__FILE__)+'/../pngout',
        color_bar: :random
      )

        png = "#{omakase.title.sub(' - Wikipedia','').gsub(/[\/\s]+/,'')}.png"
        omakase.stub(:export).and_return(File.join omakase.out_path, png)

        omakase.export.should eq File.join(omakase.out_path, png)
      end
    end
    
  end
  
end
