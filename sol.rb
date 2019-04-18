class PhoneToWord
	def create_mapping
		{
		    2 => %w(a b c),
		    3 => %w(d e f),
		    4 => %w(g h i),
		    5 => %w(j k l),
		    6 => %w(m n o),
		    7 => %w(p q r s),
		    8 => %w(t u v),
		    9 => %w(w x y z)
		}
	end

	def read_data(dict_file= 'dictionary.txt')
		raise "Couldn't Find the File #{dict_file}" unless File::exists?(dict_file)
		File.readlines(dict_file).map{|w| w.strip}.sort	
	end

	def assemble_characters(phone_number)
		char_collector = []
		phone_number.to_s.split('').uniq.each do |p|
			next if [0,1].include? p.to_i
			char_collector << create_mapping[p.to_i]			
		end
		char_collector.flatten.uniq.reject(&:nil?)
	end

	def word_exists(word, data_source= read_data)
 		data_source.bsearch{|x| word.upcase <=> x }
	end

	def word_combinations(phone, word_len= 3)
		combinations = []
		phone.each_char do |ch|
			combinations<< create_mapping[ch.to_i]
		end
		combinations.flatten.compact.combination(word_len).map(&:join)
	end

	def matching_words
		p = []
		word_combinations("234").each do |comb|
			p<< word_exists(comb)
		end
		p.compact
	end
end


# @obj= PhoneToWord.new
# puts @obj.matching_words


require "minitest/autorun"

describe "create_mapping function" do
	before do
		@obj = PhoneToWord.new
	 end
  it "return a value" do
    value(@obj.create_mapping).wont_be_nil
  end 

  it "return a,b,c for key 2" do
    value(@obj.create_mapping[2]).must_equal ['a','b','c']
  end
  it "return g,h,i for key 4" do
    value(@obj.create_mapping[4]).must_equal ['g','h','i']
  end
  it "return p,q,r,s for key 7" do
    value(@obj.create_mapping[7]).must_equal ['p','q','r', 's']
  end
  it "return w,x,y,z for key 9" do
    value(@obj.create_mapping[9]).must_equal ['w','x','y','z']
  end 
end

describe "read_data function" do
	before do
		@obj = PhoneToWord.new
	end

	it "throw an exception if dictionary file does not exist" do
		assert_raises do
			@obj.read_data('dist.txt').first
		end
	end

	it "return dictionary data if dictionary exist" do
		refute_nil(@obj.read_data)
	end

end 

describe "assemble_characters function" do
	before do
		@obj = PhoneToWord.new
	end

	it "return character array" do
		corsp_chars= @obj.assemble_characters("12345")
		assert_kind_of Array, corsp_chars
	end

	it "convert number to mapped character array" do
		corsp_chars= @obj.assemble_characters("12345")
		assert_equal corsp_chars, ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l']
	end

	it "return empty array for number consisting only 0 and 1" do
		corsp_chars= @obj.assemble_characters("1001")
		assert_equal corsp_chars, []
	end

	it "accept number input as well" do
		corsp_chars= @obj.assemble_characters(12345)
		assert_equal corsp_chars, ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l']
	end
end

describe "word_exists function" do
	before do
		@obj = PhoneToWord.new
	end

	it "returns the word if exists in data source" do
		result = @obj.word_exists("AA", ["AA", "AC", "AD"])
		assert_equal result, "AA"
	end

	it "returns nil if word does not exist in data source" do
		result = @obj.word_exists("AZ", ["AA", "AC", "AD"])
		assert_nil result
	end
end

describe "word_combinations function" do
	before do
		@obj = PhoneToWord.new
	end

	it "return the array of combinations for entered number" do
		result = @obj.word_combinations("12")
		assert_kind_of Array, result
	end

	it "return the blank aaray for number composed if 0 and 1" do
		result = @obj.word_combinations("10101")
		assert_predicate result, :empty?
	end
end

