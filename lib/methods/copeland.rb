require './lib/inits/config.rb'
require './lib/common/quick.rb'

module CopelandModule

	def self.included(base)
		base.extend(ClassMethods)
	end

	module ClassMethods

		def run data
			puts $MESSAGES[:copeland]
			scores = Hash.new { |h,k| h[k] = Hash.new {|hh,kk| hh[kk] = 0}}
			data.each do |estimator, hash|
				hash.each do |group_id, hash2|
					hash2.keys[0..-2].each_with_index do |instance_id,i|
						(i+1..hash2.keys.size-1).each do |j|
							#puts "comparing #{instance_id}:#{hash2[instance_id]} with #{hash2.keys[j]}:#{hash2[hash2.keys[j]]}"
							if hash2[instance_id] > hash2[hash2.keys[j]]
								scores[group_id][instance_id] += 1
								scores[group_id][hash2.keys[j]] -= 1
							elsif hash2[instance_id] < hash2[hash2.keys[j]]
								scores[group_id][instance_id] -= 1
								scores[group_id][hash2.keys[j]] += 1
							end
						end
					end
				end
			end

			result = {}
			scores.each do |group_id, hash|
				result[group_id] = hash.keys.sort_by { |instance_id| [-1*hash[instance_id], -1*instance_id] }
			end

			puts result
			return result
			
		end

	end

end