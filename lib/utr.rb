require './lib/config.rb'
require './lib/kemeny'

class UTR

	def initialize(config_file)
		Conf.init(config_file)
	end

	module Methods
		class Kemeny
			include KemenyModule
		end
	end

	def load_data
		data = Hash.new { |h,k| h[k] = Hash.new { |hh,kk| hh[kk] = {} }}
		Conf.estimators.each do |estimator|
			File.readlines(Conf.get_path(estimator)).each do |line|
				splitted = line.split(',')
				group_id, instance_id, score = splitted[0].to_i, splitted[1].to_i, splitted[2].to_f
				data[estimator][group_id][instance_id] = score
			end
		end
		return data
	end

	def dump_result result
		file = File.open(Conf.get_output,'w')
		result.each do |group_id, array|
			array.each_with_index do |instance_id, i|
				file.puts("#{group_id},#{instance_id},#{array.size - i}")
			end
		end
		file.close
	end

	def run
		data = load_data

		case Conf.method
		when "kemeny"
			dump_result Methods::Kemeny.new.run data
		end
	end
	
end