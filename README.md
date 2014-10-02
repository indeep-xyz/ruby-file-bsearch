FileBsearch
====

library for Ruby.

binary search for sorted text file. it is effective when file size is bigger.

## Installation

```ruby
gem install file_bsearch
```

## Usage

### check to exist line that identical with passed string

```ruby
FileBsearch.exist?(path, string)

File.bsearch?(path, string)

file = open(path)
file.bsearch?(string)
```

if exists, return true.
if not exists, return false.

### search position in file for the line that is identical with passed string

```ruby
FileBsearch.index(path, string)

File.bsearch(path, string)

file = open(path)
file.bsearch(string)
```

if exists, return Integer object that is position in file for matched line.
if not exists, return false.

### get lines that matched string with passed prefix

```ruby
FileBsearch.get_lines(path, prefix)

File.bsearch_lines(path, prefix)

file = open(path)
file.bsearch_lines(prefix)
```

if exists, return Array object that include matched lines.
if not exists, return empty Array object.

## Contributing

1. Fork it ( https://github.com/indeep-xyz/ruby-file-bsearch/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Author

[indeep-xyz](http://indeep.xyz/)