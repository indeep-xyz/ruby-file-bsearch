require "file_bsearch/version"
require "file_bsearch/main"

module FileBsearch
end

class File

  def self.bsearch(*args)
    FileBsearch.index(*args)
  end

  def bsearch(*args)
    FileBsearch.index(self, *args)
  end
end