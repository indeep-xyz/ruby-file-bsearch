FileBsearch
====

Ruby 用のライブラリです。

ソート済みのテキストファイルに対してバイナリサーチ (二分探索) をおこないます。巨大なファイルに対して効果的です。

## Installation

```ruby
gem install file_bsearch
```

## Usage

### 指定文字列の行が、ファイル内に存在するか

```ruby
FileBsearch.exist?(path, string)

File.bsearch?(path, string)

file = open(path)
file.bsearch?(string)
```

存在する場合は true 、存在しない場合は false が返ります。

### 指定文字列の行が、ファイル内のどの位置にあるか

```ruby
FileBsearch.index(path, string)

File.bsearch(path, string)

file = open(path)
file.bsearch(string)
```

存在する場合はその行の開始位置、存在しない場合は false が返ります。

### 指定文字列から始まる行の取得

```ruby
FileBsearch.get_lines(path, prefix)

File.bsearch_lines(path, prefix)

file = open(path)
file.bsearch_lines(prefix)
```

存在する場合はそれらの行の文字列を含んだ配列、存在しない場合は空の配列が返ります。

## Contributing

1. Fork it ( https://github.com/indeep-xyz/ruby-file-bsearch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Author

[indeep-xyz](http://indeep.xyz/)