require 'yaml'

$ERRORS = YAML::load(File.open("./lib/inits/errors.yml")).inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}

class Conf

	def self.init(config_file)
		begin
			@@params = YAML::load(File.open(config_file)).inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
			@@params[:estimators].each { |estimator,hash| hash["weight"] ||= 1 }

			self.validate @@params

		rescue Psych::SyntaxError
			abort($ERRORS[:syntax])
		rescue Errno::ENOENT
			abort($ERRORS[:conf_not_found])
		end
	end

	def self.method
		return @@params[:method]
	end

	def self.estimators
		return @@params[:estimators].keys
	end

	def self.get_path(estimator)
		return @@params[:estimators][estimator]["path"]
	end

	def self.get_weight(estimator)
		return @@params[:estimators][estimator]["weight"]
	end

	def self.get_output
		return @@params[:out]
	end

	def self.get_ev_method
		return @@params[:evaluation]["method"]
	end

	def self.get_ev_solution
		return @@params[:evaluation]["solution_file"]
	end

	private
		def self.validate params
			abort($ERRORS[:no_out]) unless params[:out]
			abort($ERRORS[:no_method]) unless params[:method]
			#abort(ERRORS[:no_ev_method]) (if params[:evaluation] and !params[:evaluation]["method"])
			abort($ERRORS[:no_ev_solution]) if (params[:evaluation] and !params[:evaluation]["solution_file"])
		end
end