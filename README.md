FileBsearch
====

library for Ruby.

binary search for sorted text file. it is effective when file size is bigger.

## Installation

```ruby
gem install file_bsearch
```

## Usage

### common arguments

common arguments in usage document. mean of each arguments are following.

#### encoding

for character encodings. you can pass String object that is 'utf8', 'eucjp', 'jis', 'sjis' or each prefix. if you pass nil or does not pass, search for ascii character.

#### path

path for sorted text file.

#### string

string for search.

#### prefix

string for prefix search.

### check to exist line that identical with passed string

```ruby
FileBsearch.exist?(path, string, encoding)

File.bsearch?(path, string, encoding)

file = open(path)
file.bsearch?(string, encoding)
```

if exists, return true.
if not exists, return false.

### search position in file for the line that is identical with passed string

```ruby
FileBsearch.index(path, string, encoding)

File.bsearch(path, string, encoding)

file = open(path)
file.bsearch(string, encoding)
```

if exists, return Integer object that has the position of file pointer for head of matched line.
if not exists, return false.

### get lines that matched string with passed prefix

```ruby
FileBsearch.get_lines(path, prefix, encoding)

File.bsearch_lines(path, prefix, encoding)

file = open(path)
file.bsearch_lines(prefix, encoding)
```

if exists, return Array object that has the matched lines.
if not exists, return empty Array object.

## Contributing

1. Fork it ( https://github.com/indeep-xyz/ruby-file-bsearch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Author

[indeep-xyz](http://indeep.xyz/) (Japanese language)