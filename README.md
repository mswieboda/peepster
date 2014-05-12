peepster
========

Command line Ruby app to parse records of people's information, and output them sorted, eventually utilzing a [GrapeAPI](https://github.com/intridea/grape) to access different sorting options.

Usage
--------

Command Line:
```
ruby app/peepster.rb --gender spec/fixtures/test1.csv spec/fixtures/test2.csv spec/fixtures/test3.csv
```

Rack web server:
```
rackup
```

```
http://0.0.0.0:9292/records[/gender|birth|last]
```
