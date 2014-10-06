# PAL

## About
PAL is a ranking aggregation library [Intelligent Information Systems Labratory](http://ece.ut.ac.ir/en/lab/intelligent-information-system-lab) of [ECE](http://ece.ut.ac.ir/), developed
to be used in [ACM Recsys Challenge 2014](http://2014.recsyschallenge.com)

## Supported Methods

* Supervised Kemeny Ranking
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
method: borda
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




