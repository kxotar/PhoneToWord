class PhoneToWord

	def initialize(phone, data_source= read_data('dictionary.txt'), word_length= 3)
		@phone= phone.to_s
		@data_source = data_source
		@char_map = create_mapping
		@word_len = word_length

	end

	def matching_words
		raise "Phone should be atleast 3 characters long" if @phone.size < 3
		p = []
		word_combinations.each do |comb|
			p<< search_word(comb)
		end
		p.compact
	end

	private

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

	def read_data(dict_file)
		raise "Couldn't Find the File #{dict_file}" unless File::exists?(dict_file)
		File.readlines(dict_file).map{|w| w.strip}.sort
	end

	def assemble_characters
		char_collector = []
		@phone.split('').uniq.each do |p|
			next if [0,1].include? p.to_i
			char_collector << create_mapping[p.to_i]
		end
		char_collector.flatten.uniq.reject(&:nil?)
	end

	def search_word(word)
 		@data_source.bsearch{|x| word.upcase <=> x }
	end

	def word_combinations
		combinations = []
		@phone.each_char do |ch|
			combinations<< create_mapping[ch.to_i]
		end
		combinations.flatten.compact.combination(@word_len).map(&:join)
	end
end