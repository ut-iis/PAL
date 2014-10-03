require './lib/inits/config.rb'

module BordaModule

	def self.included(base)
		base.extend(ClassMethods)
	end

	module ClassMethods

		def run data
			puts $MESSAGES[:borda]
			
			scores = Hash.new { |h,k| h[k] = Hash.new { |hh,kk| hh[kk] = 0 }}
			data.each do |estimator,hash|
				hash.each do |group_id, hash2|
					hash2.each do |instance_id, score|
						scores[group_id][instance_id] += score
					end
				end
			end

			result = {}
			scores.each do |group_id, hash|
				result[group_id] = hash.keys.sort_by { |instance_id| [-1*hash[instance_id], -1*instance_id] }
			end
			return result
		end

	end

end