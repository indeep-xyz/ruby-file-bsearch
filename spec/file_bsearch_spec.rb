require 'spec_helper'

describe FileBsearch do

  let(:path)      { '/tmp/file_bsearch_sample.csv' }
  let(:correct)   { '9' }
  let(:incorrect) { '!!!!!' }

  let!(:helper) { MySpecHelper.new(path) }

  it 'has a version number' do
    expect(FileBsearch::VERSION).not_to be nil
  end

  describe 'module' do

    describe '#exist?' do

      it 'when a record is exists' do

        result = FileBsearch.exist?(path, correct)

        expect(result).to eq(true)
      end

      it 'when a record is not exist' do

        result = FileBsearch.exist?(path, incorrect)

        expect(result).to eq(false)
      end

      it 'when all records are exist' do

        File.foreach(path) do |line|

          correct  = line.chomp
          result = FileBsearch.exist?(path, correct)

          expect(result).to eq(true)
        end
      end
    end

    describe '#index' do

      it 'when returner is number as position in the file' do

        b_result = FileBsearch.index(path, correct)
        h_result = helper.correct?(correct, b_result)

        expect(h_result).to eq(true)
      end

      it 'when returner is false' do

        result = FileBsearch.index(path, incorrect)
        expect(result).to eq(false)
      end
    end

    describe '#get_lines' do
      it 'when lines is exist that with the prefix' do

        result = FileBsearch.get_lines(path, '1000')

        expect(result).to eq(%w{1000 10000})
      end

      it 'when lines is not exist that with the prefix' do

        result = FileBsearch.get_lines(path, '!!!!!')

        expect(result).to eq([])
      end
    end
  end

  describe 'instance method' do

    let(:file) { open(path) }

    describe '#bsearch' do

      it 'when returner is number as position in the file' do

        b_result = file.bsearch(correct)
        h_result = helper.correct?(correct, b_result)

        expect(h_result).to eq(true)
      end
    end

    describe '#bsearch?' do
      it 'when a record is exists' do

        result = file.bsearch?(correct)

        expect(result).to eq(true)
      end
    end

    describe '#bsearch_lines' do
      it 'when lines is exist that with the prefix' do

        result = file.bsearch_lines('1000')

        expect(result).to eq(%w{1000 10000})
      end
    end
  end

  describe 'class method' do

    describe '#bsearch' do

      it 'when returner is number as position in the file' do

        b_result = File.bsearch(path, correct)
        h_result = helper.correct?(correct, b_result)

        expect(h_result).to eq(true)
      end
    end

    describe '#bsearch?' do
      it 'when a record is exists' do

        result = File.bsearch?(path, correct)

        expect(result).to eq(true)
      end
    end

    describe '#bsearch_lines' do
      it 'when lines is exist that with the prefix' do

        result = File.bsearch_lines(path, '1000')

        expect(result).to eq(%w{1000 10000})
      end
    end
  end
end
