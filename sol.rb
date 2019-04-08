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
		File.readlines(dict_file) 	
	end
end

begin
	@obj = PhoneToWord.new
	puts @obj.read_data.first
rescue StandardError => e 
	puts e.message
end


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
