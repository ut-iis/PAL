class NDCG
	
	def initialize(list)
		@list = list
		@at = 10
	end

	def CG
		@list[0..@at].inject(0) { |sum,x| sum + x}
	end

	def DCG(list)
		list[0..@at].each.with_index.inject(0) { |sum,(x,i) | sum + ((2**x - 1) / (Math::log(i+2) / Math::log(2)))}
	end

	def IDCG
		self.DCG(@list.sort.reverse)
	end

	def at num
		@at = num - 1
		dcg = DCG(@list).to_f
		idcg = IDCG()
		return (idcg == 0 ? 0 : (dcg / idcg))
	end
end