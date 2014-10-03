require './lib/common/ndcg.rb'

class NDCGev

	def self.calculate(real_solution, my_solution, at)
		real = File.readlines(real_solution)
		my = File.readlines(my_solution)
		
		if(my.size != real.size)
			abort("some predictions are missing")
		end

		index = 0
		sum = 0
		c = 0
		while index < my.size
			line = my[index]
			real_list = []
			temp_index = index
			while temp_index < my.size
				words = real[temp_index].split(',')
				break if words[0] != my[index].split(',')[0]
				real_list << [words[1],words[2].strip.to_i]
				temp_index += 1
			end

			size = real_list.size
		
			my_rel = my[index..temp_index-1].map { |l| real_list.find { |w| w[0] == l.split(',')[1]} [1]} 
			ndcg = NDCG.new(my_rel).at(at)
			if(ndcg != 0 or (ndcg == 0 and my_rel.uniq != [0]))
				sum += ndcg
				c += 1
			end
			index = temp_index
		end

		return sum.to_f / c
	end
end