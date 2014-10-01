class MySpecHelper

  attr_reader :path

  def initialize(path)

    @path = path

    init_sample_file
  end

  def init_sample_file

    # guard
    # - if file is already exists, do not
    return nil if File.exist?(@path)

    # create sorted string
    str = (0..10_000).to_a.sort { |a, b| a.to_s <=> b.to_s }.join("\n")

    IO.write(@path, str)
  end

  # check returner
  #
  # args
  #   str ... string for correct
  #   pos ... position in the file (FileBsearch#returner)
  def correct?(str, pos)
    str == IO.read(@path, str.size, pos)
  end
end