# Omakasepng

ja.wikipedia.org の「[おまかせ表示](http://ja.wikipedia.org/wiki/%E7%89%B9%E5%88%A5:%E3%81%8A%E3%81%BE%E3%81%8B%E3%81%9B%E8%A1%A8%E7%A4%BA)」の内容をpngにする


![ミルモでポン!](examples/ミルモでポン!.png)

    $ ./bin/omakase --size 320 --color blue
    
デフォルトでは

* サイズ：960px
* カラーバー：ランダム
* 保存先： ./pngout

## Installation

Add this line to your application's Gemfile:

    gem 'omakasepng', git: https://github.com/milligramme/omakasepng.git

And then execute:

    $ bundle

Or install it yourself as:

    $ git clone https://github.com/milligramme/omakasepng.git
    $ cd omakasepng
    $ rake install

## Usage
    +---------------+
    |               |
    |               |
    +---------------|
    |               |
    |               |
    |  OMAKASE PNG  | generate png with ja.wikipedia.org omakase page
    |               |
    |               |
    |               +
    +---------------v
    Usage: omakase [options]

    Example:
      omakase -s 640 -c yellow -o ~/Desktop

    Options:
        -s, --size [SIZE]px              Size x Size. unit:px, default:960px
        -o, --out [OUTPUT_PATH]          Output path. default: ./pngout
        -c, --color [COLOR]              Color Bar. default:random, [cyan,magenta,yellow,green,red,blue]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
