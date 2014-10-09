FileBsearch
====

Ruby 用のライブラリです。

ソート済みのテキストファイルに対してバイナリサーチ (二分探索) をおこないます。巨大なファイルに対して効果的です。

## Installation

```ruby
gem install file_bsearch
```

## Usage

### 引数

Usage のドキュメント内で使用する共通の変数について、以下に解説を記します。

#### encoding

文字コードの指定。

utf8, eucjp, jis, sjis か、それぞれの接頭辞を渡してください。省略するとアスキー文字で検索をおこないます。

#### path

ソート済みのテキストファイルのパス。

#### string

検索に用いる文字列。

#### prefix

検索に用いる、接頭辞を表す文字列。

### 指定文字列の行が、ファイル内に存在するか

```ruby
FileBsearch.exist?(path, string, encoding)

File.bsearch?(path, string, encoding)

file = open(path)
file.bsearch?(string, encoding)
```

存在する場合は true 、存在しない場合は false を返します。

### 指定文字列の行が、ファイル内のどの位置にあるか

```ruby
FileBsearch.index(path, string, encoding)

File.bsearch(path, string, encoding)

file = open(path)
file.bsearch(string, encoding)
```

存在する場合はその行の先頭のファイルポインタ位置の数値、存在しない場合は false を返します。

### 指定文字列から始まる行の取得

```ruby
FileBsearch.get_lines(path, prefix, encoding)

File.bsearch_lines(path, prefix, encoding)

file = open(path)
file.bsearch_lines(prefix, encoding)
```

存在する場合はそれらの行の文字列を含んだ配列、存在しない場合は空の配列を返します。

## Contributing

1. Fork it ( https://github.com/indeep-xyz/ruby-file-bsearch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Author

[indeep-xyz](http://indeep.xyz/)