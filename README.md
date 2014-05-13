peepster
========

Command line Ruby app to parse records of people's information, and output them sorted, eventually utilzing a [GrapeAPI](https://github.com/intridea/grape) to access different sorting options.

Usage
--------

Command Line:
```
format:
$ ruby app/peepster.rb --[gender|birthdate|name] [files]

ex:
$ ruby app/peepster.rb --gender spec/fixtures/test1.csv spec/fixtures/test2.csv spec/fixtures/test3.csv
```

Rack web server:
```
$ rackup
```

URL:
```
GET  http://0.0.0.0:9292/records[/gender|birthdate|name]
POST http://0.0.0.0:9292/records

ex:
GET  http://0.0.0.0:9292/records/gender
POST http://0.0.0.0:9292/records
     send "Frusciante | John | Male | Red | 3/5/1970" in "record" param
using cURL:
curl -d '{"record": "Frusciante | John | Male | Red | 3/5/1970"}' 'http://0.0.0.0:9292/records' -H Content-Type:application/json -v
```
