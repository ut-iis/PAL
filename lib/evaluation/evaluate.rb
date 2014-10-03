require './lib/evaluation/ndcg'

module EvaluateModule

	def self.included(base)
		base.send :include, InstanceMethods
	end

	module InstanceMethods
		def initialize(solution_file, prediction_file)
			@solution_file = solution_file
			@prediction_file = prediction_file
		end

		def by(method)
			case method
			when "NDCG@10"
				return NDCGev.calculate(@solution_file, @prediction_file, 10)
			end
		end
	end
end
