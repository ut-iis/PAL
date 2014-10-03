require './lib/inits/config.rb'
require './lib/methods/kemeny'
require './lib/methods/borda'
require './lib/methods/copeland'
require './lib/methods/schulze'
require './lib/evaluation/evaluate'

class UTR

	def initialize(config_file)
		Conf.init(config_file)
	end

	module Methods
		class Kemeny
			include KemenyModule
		end

		class Borda
			include BordaModule
		end

		class Copeland
			include CopelandModule
		end

		class Schulze
			include SchulzeModule
		end
	end

	class Evaluatation
		include EvaluateModule
	end

	def load_data
		puts $MESSAGES[:loading_data]

		data = Hash.new { |h,k| h[k] = Hash.new { |hh,kk| hh[kk] = {} }}
		Conf.estimators.each_with_index do |estimator,i|
			File.readlines(Conf.get_path(estimator)).each do |line|
				splitted = line.split(',')
				group_id, instance_id, score = splitted[0].to_i, splitted[1].to_i, splitted[2].to_f
				data[estimator][group_id][instance_id] = score
			end
		end

		validate data

		return data
	end

	def dump_result result
		puts $MESSAGES[:dumping]

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
			dump_result Methods::Kemeny.run data
		when "borda"
			dump_result Methods::Borda.run data
		when "copeland"
			dump_result Methods::Copeland.run data
		when "schulze"
			dump_result Methods::Schulze.run data
		end

		puts $MESSAGES[:done]
	end

	def evaluate(method)
		puts $MESSAGES[:evaluating]

		Conf.estimators.each do |estimator|
			result = Evaluatation.new(Conf.get_ev_solution, Conf.get_path(estimator)).by(method)
			puts "#{estimator} #{method} -> #{result}"
		end
		result = Evaluatation.new(Conf.get_ev_solution, Conf.get_output).by(method)
		puts "#{Conf.method} aggregation method #{method} -> #{result} "
	end

	private
	def validate data
		data.keys[0..-2].each_with_index do |estimator, i|
			abort(ERROR[:group_ids_not_match]) if data[estimator].keys.sort != data[data.keys[i+1]].keys.sort
			data[estimator].each do |group_id, hash|
				abort($ERRORS[:instance_ids_not_match]) if hash.keys.sort != data[data.keys[i+1]][group_id].keys.sort
			end
		end
	end
	
end