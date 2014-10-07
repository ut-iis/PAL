require './lib/pal.rb'

pal = PAL.new("/home/pooya/Projects/PAL/lib/inits/config.yml")
pal.run
#pal.evaluate("NDCG@10")