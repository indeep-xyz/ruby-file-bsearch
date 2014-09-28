require 'spec_helper'

describe FileBsearch do

  # let(:path) { '/tmp/file_bsearch_sample.csv' }
  let(:path) { '/tmp/blocked_sld_2013/aaa.csv' }
  let(:value) { {
        # correct: '98',
        correct: '2010',
      incorrect: '!!!!!',
      } }

  before do

    unless File.exist?(path)
      open(path, 'w') do |f|

        ary  = (0..100).to_a.sort { |a, b| a.to_s <=> b.to_s }
        f.write(ary.join("\n"))
      end
    end
  end

  it 'has a version number' do
    expect(FileBsearch::VERSION).not_to be nil
  end

  describe 'instance method' do

    let(:file) { open(path) }

    it 'when #bsearch, exists' do
      result = file.bsearch(value[:correct])
      expect(result).to eq(true)
    end

    it 'when #bsearch, not exists' do
      result = file.bsearch(value[:incorrect])
      expect(result).to eq(false)
    end

    it 'when #bsearch all exists' do

      File.foreach(path) do |line|
        result = file.bsearch(line.chomp)
        expect(result).to eq(true)
      end
    end

  describe 'class method' do

    it 'when #bsearch, exists' do
      result = File.bsearch(path, value[:correct])
      expect(result).to eq(true)
    end
  end

  end
end
