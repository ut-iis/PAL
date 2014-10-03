require './lib/inits/config.rb'
require './lib/common/quick.rb'

module KemenyModule

	def self.included(base)
		base.extend(ClassMethods)
	end

	module ClassMethods

		def run data
			puts $MESSAGES[:kemeny]

			candidates = Hash.new { |h,k| h[k] = Hash.new { |hh,kk| hh[kk] = {} } } # we need a hash with instance ids as keys
			data.each do |estimator, hash|
				hash.each do |group_id, hash2|
					hash2.each { |instance_id, score| candidates[group_id][instance_id][estimator] = score }
				end
			end

			result = {}
			candidates.keys.sort.each do |group_id|
				result[group_id] = aggregate candidates[group_id]
			end

			return result
		end

		def aggregate candidates
			# puts "candidates: #{candidates}"
			# puts ""

			majority_table = Hash.new { |h,k| h[k] = {} }
			(0..candidates.size - 1).each do |i| # initializing the majority table
				(0..candidates.size - 1).each do |j|
					majority_table[i] ||= {}
					majority_table[i][j] = 0
				end
			end

			Conf.estimators.each do |estimator|
				weight = Conf.get_weight(estimator)
				(0..candidates.keys.size - 2).each do |i|
					hash1 = candidates[candidates.keys[i]]
					(i+1..candidates.keys.size - 1).each do |j|
						hash2 = candidates[candidates.keys[j]]
						if(hash1[estimator] > hash2[estimator])
							majority_table[i][j] += weight
						elsif(hash1[estimator] < hash2[estimator])
							majority_table[j][i] += weight
						end
					end
				end
			end

			keys = candidates.keys
			result = keys

			# puts "before: #{result}"
			# puts "majority table: #{majority_table}"
			comp = Proc.new do |value1, value2|
				j = candidates.keys.index(value1)
				jp = candidates.keys.index(value2)
				if majority_table[j][jp] > majority_table[jp][j]
					-1
				elsif majority_table[j][jp] < majority_table[jp][j]
					1
				else
					0
				end
			end

			QuickSort.sort!(result, comp)

#			puts "result: #{result}"
			return result
		end
	end

end