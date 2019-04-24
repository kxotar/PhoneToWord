require "minitest/autorun"
require "./sol"

describe "create_mapping function" do
    before do
        @obj = PhoneToWord.new('24')
     end
  it "return a value" do
    value(@obj.send(:create_mapping)).wont_be_nil
  end

  it "return a,b,c for key 2" do
    value(@obj.send(:create_mapping)[2]).must_equal ['a','b','c']
  end
  it "return g,h,i for key 4" do
    value(@obj.send(:create_mapping)[4]).must_equal ['g','h','i']
  end
  it "return p,q,r,s for key 7" do
    value(@obj.send(:create_mapping)[7]).must_equal ['p','q','r', 's']
  end
  it "return w,x,y,z for key 9" do
    value(@obj.send(:create_mapping)[9]).must_equal ['w','x','y','z']
  end
end

describe "read_data function" do
    before do
        @obj = PhoneToWord.new('24', 'dictionary.txt')
    end

    it "throw an exception if dictionary file does not exist" do
        assert_raises do
            @obj_er = PhoneToWord.new('24', @obj_er.send(:read_data, 'dist.txt'))
        end
    end

    it "return dictionary data if dictionary exist" do
        refute_nil(@obj.send(:read_data, 'dictionary.txt'))
    end

end

describe "assemble_characters function" do
    before do
        @obj1 = PhoneToWord.new('12345')
        @obj2 = PhoneToWord.new('1001')
    end

    it "return character array" do
        corsp_chars= @obj1.send(:assemble_characters)
        assert_kind_of Array, corsp_chars
    end

    it "convert number to mapped character array" do
        corsp_chars= @obj1.send(:assemble_characters)
        assert_equal corsp_chars, ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l']
    end

    it "return empty array for number consisting only 0 and 1" do
        corsp_chars= @obj2.send(:assemble_characters)
        assert_equal corsp_chars, []
    end

    it "accept number input as well" do
        corsp_chars= @obj1.send(:assemble_characters)
        assert_equal corsp_chars, ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l']
    end
end

describe "search_word function" do
    before do
        @obj = PhoneToWord.new('22', ["AA", "AC", "AD"])
    end

    it "returns the word if exists in data source" do
        result = @obj.send(:search_word,"AA")
        assert_equal result, "AA"
    end

    it "returns nil if word does not exist in data source" do
        result = @obj.send(:search_word,"AZ")
        assert_nil result
    end
end

describe "word_combinations function" do
    before do
        @obj1 = PhoneToWord.new('12')
        @obj2 = PhoneToWord.new('10101')
    end

    it "return the array of combinations for entered number" do
        result = @obj1.send(:word_combinations)
        assert_kind_of Array, result
    end

    it "return the blank aaray for number composed if 0 and 1" do
        result = @obj2.send(:word_combinations)
        assert_predicate result, :empty?
    end
end

describe "matching_words" do
    before do
        @obj = PhoneToWord.new('22', ["AA", "AC", "AD", "AMD","APC"],2)
    end

    it "return the list of match words from data source" do
        result= @obj.matching_words
        assert_kind_of Array, result
    end

    it "return the matching words from data source" do
        result= @obj.matching_words
        assert_includes result, "AA"
    end
end
