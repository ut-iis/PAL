# PAL
Pereference/Ranking Aggregation Library

## About
PAL is a ranking aggregation Ruby library developed in [Intelligent Information Systems Labratory](http://ece.ut.ac.ir/en/lab/intelligent-information-system-lab) of [School of ECE](http://ece.ut.ac.ir/) at [University of Tehran](http://ut.ac.ir/en/). 


## Supported Methods

* Weighted Kemeny Ranking
* Borda Count
* Copeland
* Schulze

## Getting started

At first you should clone the library.

```console
git clone git@github.com:ut-iis/PAL.git
```
Now you should edit the sample config file according to your needs.

```yaml
method: kemeny
out: /home/pooya/Projects/UTR/samples/output.dat
estimators:
    listnet:
      path: /home/pooya/Projects/UTR/samples/listnet.dat
      weight: 2
    ranknet:
      path: /home/pooya/Projects/UTR/samples/ranknet.dat
      weight: 3
    listmle:
      path: /home/pooya/Projects/UTR/samples/listmle.dat
      weight: 3
    svm:
      path: /home/pooya/Projects/UTR/samples/svm.dat
      weight: 1
evaluation:
    solution_file: /home/pooya/Projects/UTR/samples/solution.dat
```

Then in the `rank.rb` file you should address the config file and set if you want to evaluate the aggregation or not.
```ruby
require './lib/pal.rb'

utr = UTR.new("/home/pooya/Projects/PAL/lib/inits/config.yml")
utr.run
#utr.evaluate("NDCG@10")
```

And finally:
```console
ruby rank.rb
```

## Citation

You can cite our paper published in ACM RecSys 2014:

```bib
@inproceedings{Zamani:2014,
  author    = {Zamani, Hamed and
               Shakery, Azadeh and
			   Moradi, Pooya},
  title     = {Regression and Learning to Rank Aggregation for User Engagement Evaluation},
  booktitle = {Proceedings of the 2014 Recommender Systems Challenge},
  series = {RecSysChallenge '14},
  location = {Foster City, CA, USA},
  year      = {2014},
  publisher	= {ACM},
  address	= {New York, NY, USA}
}
```




