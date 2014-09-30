require 'spec_helper'

describe FileBsearch do

  let(:path) { '/tmp/file_bsearch_sample.csv' }
  let(:correct) { '9' }
  let(:incorrect) { '!!!!!' }

  # let(:path) { '/tmp/blocked_sld_2013/song.csv' }
  # let(:path) { '/tmp/blocked_sld_2013/iwc.csv' }
  # let(:correct) { '2010' }

  let!(:helper) { MySpecHelper.new(path) }

  it 'has a version number' do
    expect(FileBsearch::VERSION).not_to be nil
  end

  describe 'module' do

    describe '#index' do

      it 'a record is exists' do

        b_result = FileBsearch.index(path, correct)
        h_result = helper.correct?(correct, b_result)

        expect(h_result).to eq(true)
      end

      it 'a record is not exists' do

        result = FileBsearch.index(path, incorrect)
        expect(result).to eq(false)
      end

      it 'when all records are exist' do

        File.foreach(path) do |line|

          correct  = line.chomp
          b_result = FileBsearch.index(path, correct)
          h_result = helper.correct?(correct, b_result)

          expect(h_result).to eq(true)
        end
      end
    end
  end

  describe 'instance method' do

    let(:file) { open(path) }

    describe '#bsearch' do

      it 'a record is exists' do

        b_result = file.bsearch(correct)
        h_result = helper.correct?(correct, b_result)

        expect(h_result).to eq(true)
      end
    end
  end

  describe 'class method' do

    it 'when #bsearch, exists' do

      b_result = File.bsearch(path, correct)
      h_result = helper.correct?(correct, b_result)

      expect(h_result).to eq(true)
    end
  end
end
