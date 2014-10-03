require './lib/inits/config.rb'

module SchulzeModule

	def self.included(base)
		base.extend(ClassMethods)
	end

	module ClassMethods

		def run data
			puts $MESSAGES[:schulze]
			pref = get_pref data

			result = {}
			pref.each do |group_id, hash|
				all = (hash.keys + hash.map { |k,h| hash.keys}.flatten).uniq
				strength = get_strength hash, all
				result[group_id] = all.sort! { |i,j| strength[j][i] <=> strength[i][j] }
			end

			return result
		end

		def get_pref data
			pref = Hash.new { |h,k| h[k] = Hash.new { |hh,kk| hh[kk] = Hash.new { |hhh,kkk| hhh[kkk] = 0} }}

			data.each do |estimator,hash|
				hash.each do |group_id, hash2|
					hash2.keys.sort_by { |instance_id| hash2[instance_id] }.reverse[0..-2].each_with_index do |instance_id, i|
						pref[group_id][instance_id][hash2.keys[i+1]] += 1
					end
				end
			end

			return pref
		end

		def get_strength pref, all
			result  = Hash.new { |h,k| h[k] = {}}
			all.each do |i|
				all.each do |j|
					if(i != j)
						pref[i][j] ||= 0
						pref[j][i] ||= 0

						if pref[i][j] > pref[j][i]
							result[i][j] = pref[i][j]
						else
							result[i][j] = 0
						end
					end
				end
			end

			all.each do |i|
				all.each do |j|
					if i != j
						all.each do |k|
							result[j][k] = [result[j][k], [result[j][i], result[i][k]].min].max if (i != k and j != k)
						end
					end
				end
			end

			return result
		end

	end

end