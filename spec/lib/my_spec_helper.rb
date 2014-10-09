# coding: utf-8

class MySpecHelper

  attr_reader :path

  ASCII_SAMPLE_PATH     = '/tmp/file_bsearch_sample_ascii.csv'
  MULTIBYTE_SAMPLE_PATH = '/tmp/file_bsearch_sample_multibyte.csv'

  ASCII_ARG          = '9'
  ASCII_LIST_ARG     = '1000'
  ASCII_LIST_CORRECT = %w{1000 10000}
  INCORRECT          = '!!!!!'

  MULTIBYTE_ARG          = 'ああ'
  MULTIBYTE_LIST_ARG     = 'あ'
  MULTIBYTE_LIST_CORRECT = ["あぁ", "ああ", "あぃ", "あい", "あぅ", "あう", "あぇ", "あえ", "あぉ", "あお", "あか", "あが", "あき", "あぎ", "あく", "あぐ", "あけ", "あげ", "あこ", "あご", "あさ", "あざ", "あし", "あじ", "あす", "あず", "あせ", "あぜ", "あそ", "あぞ", "あた", "あだ", "あち", "あぢ", "あっ", "あつ", "あづ", "あて", "あで", "あと", "あど", "あな", "あに", "あぬ", "あね", "あの", "あは", "あば", "あぱ", "あひ", "あび", "あぴ", "あふ", "あぶ", "あぷ", "あへ", "あべ", "あぺ", "あほ", "あぼ", "あぽ", "あま", "あみ", "あむ", "あめ", "あも", "あゃ", "あや", "あゅ", "あゆ", "あょ", "あよ", "あら", "あり", "ある", "あれ", "あろ", "あゎ", "あわ", "あゐ", "あゑ", "あを", "あん", "あゔ", "あゕ", "あゖ"]

  def initialize

    init_ascii_sample
    init_multibyte_sample
  end

  def init_ascii_sample

    path = ASCII_SAMPLE_PATH

    # guard
    # - if file is already exists, do not
    return nil if File.exist?(path)

    # create sorted string
    str = create_lines(0..10_000)

    IO.write(path, str)
  end

  def init_multibyte_sample

    path = MULTIBYTE_SAMPLE_PATH

    # guard
    # - if file is already exists, do not
    return nil if File.exist?(path)

    # create sorted string
    str = create_lines('ぁぁ'..'んん')

    IO.write(path, str)
  end

  # check correct for ascii file
  #
  # args
  #   pos ... Integer object for position in file
  #           (returner of FileBsearch#index)
  #   str ... String object for comparison
  def ascii_correct?(pos, str)
    str == IO.read(ASCII_SAMPLE_PATH, str.bytesize, pos)
  end

  # check correct for ascii file
  #
  # args
  #   pos ... Integer object for position in file
  #           (returner of FileBsearch#index)
  #   str ... String object for comparison
  def multibyte_correct?(pos, str)

    read_str = IO.read(MULTIBYTE_SAMPLE_PATH, str.bytesize, pos)
    str == read_str.toutf8
  end

  private

  def create_lines(range)
    range.to_a.sort { |a, b| a.to_s <=> b.to_s }.join("\n")
  end
end