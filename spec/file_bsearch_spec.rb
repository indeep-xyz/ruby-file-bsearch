# coding: utf-8

require 'spec_helper'

describe FileBsearch do

  it 'has a version number' do
    expect(FileBsearch::VERSION).not_to be nil
  end
end

describe '<ASCII FILE>' do

  let!(:helper)   { MySpecHelper.new }
  let(:path)      { MySpecHelper::ASCII_SAMPLE_PATH }
  let(:incorrect) { MySpecHelper::INCORRECT }

  describe 'module' do

    describe '#exist?' do

      it 'when a record is exists' do

        arg    = MySpecHelper::ASCII_ARG
        result = FileBsearch.exist?(path, arg)

        expect(result).to eq(true)
      end

      it 'when a record is not exist' do

        result = FileBsearch.exist?(path, incorrect)
        expect(result).to eq(false)
      end

      it 'when all records are exist' do

        File.foreach(path) do |line|

          arg    = line.chomp
          result = FileBsearch.exist?(path, arg)

          expect(result).to eq(true)
        end
      end
    end

    describe '#index' do

      it 'when returner is number as position in the file' do

        arg    = MySpecHelper::ASCII_ARG
        pos    = FileBsearch.index(path, arg)

        result = helper.ascii_correct?(pos, arg)
        expect(result).to eq(true)
      end

      it 'when returner is false' do

        result = FileBsearch.index(path, incorrect)
        expect(result).to eq(false)
      end
    end

    describe '#get_lines' do
      it 'when lines is exist that with the prefix' do

        arg     = MySpecHelper::ASCII_LIST_ARG
        correct = MySpecHelper::ASCII_LIST_CORRECT

        result  = FileBsearch.get_lines(path, arg)
        expect(result).to eq(correct)
      end

      it 'when lines is not exist that with the prefix' do

        result = FileBsearch.get_lines(path, incorrect)
        expect(result).to eq([])
      end
    end
  end

  describe 'instance method' do

    let(:file)  { open(path) }

    describe '#bsearch' do

      it 'when returner is number as position in the file' do

        arg    = MySpecHelper::ASCII_LIST_ARG
        pos    = file.bsearch(arg)
        result = helper.ascii_correct?(pos, arg)

        expect(result).to eq(true)
      end
    end

    describe '#bsearch?' do
      it 'when a record is exists' do

        arg    = MySpecHelper::ASCII_LIST_ARG
        result = file.bsearch?(arg)

        expect(result).to eq(true)
      end
    end

    describe '#bsearch_lines' do
      it 'when lines is exist that with the prefix' do

        arg     = MySpecHelper::ASCII_LIST_ARG
        correct = MySpecHelper::ASCII_LIST_CORRECT

        result = file.bsearch_lines(arg)
        expect(result).to eq(correct)
      end
    end
  end

  describe 'class method' do

    describe '#bsearch' do

      it 'when returner is number as position in the file' do

        arg    = MySpecHelper::ASCII_LIST_ARG
        pos    = File.bsearch(path, arg)
        result = helper.ascii_correct?(pos, arg)

        expect(result).to eq(true)
      end
    end

    describe '#bsearch?' do
      it 'when a record is exists' do

        arg    = MySpecHelper::ASCII_LIST_ARG
        result = File.bsearch?(path, arg)

        expect(result).to eq(true)
      end
    end

    describe '#bsearch_lines' do
      it 'when lines is exist that with the prefix' do

        arg     = MySpecHelper::ASCII_LIST_ARG
        correct = MySpecHelper::ASCII_LIST_CORRECT

        result = File.bsearch_lines(path, arg)
        expect(result).to eq(correct)
      end
    end
  end
end

describe '<UTF-8 FILE>' do

  let!(:helper)   { MySpecHelper.new }
  let(:path)      { MySpecHelper::MULTIBYTE_SAMPLE_PATH }
  let(:incorrect) { MySpecHelper::INCORRECT }
  let(:arg)       { MySpecHelper::MULTIBYTE_ARG }
  let(:list_arg)  { MySpecHelper::MULTIBYTE_LIST_ARG }

  describe 'module' do

    describe '#exist?' do

      it 'when a record is exists' do

        result = FileBsearch.exist?(path, arg, 'utf-8')
        expect(result).to eq(true)
      end

      it 'when a record is not exist' do

        result = FileBsearch.exist?(path, incorrect, 'utf-8')
        expect(result).to eq(false)
      end

      it 'when all records are exist' do

        File.foreach(path) do |line|

          arg    = line.chomp
          result = FileBsearch.exist?(path, arg, 'utf-8')

          expect(result).to eq(true)
        end
      end
    end

    describe '#index' do

      it 'when returner is number as position in the file' do

        pos    = FileBsearch.index(path, arg, 'utf-8')
        result = helper.multibyte_correct?(pos, arg)
        expect(result).to eq(true)
      end

      it 'when returner is false' do

        result = FileBsearch.index(path, incorrect, 'utf-8')
        expect(result).to eq(false)
      end
    end

    describe '#get_lines' do
      it 'when lines is exist that with the prefix' do

        correct = MySpecHelper::MULTIBYTE_LIST_CORRECT
        result  = FileBsearch.get_lines(path, list_arg, 'utf-8')
        expect(result).to eq(correct)
      end

      it 'when lines is not exist that with the prefix' do

        result = FileBsearch.get_lines(path, incorrect, 'utf-8')
        expect(result).to eq([])
      end
    end
  end
end
