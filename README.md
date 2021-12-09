# fluent-plugin-num-comparison
[![RakeTest](https://github.com/homirun/fluent-plugin-num-comparison/actions/workflows/test.yaml/badge.svg)](https://github.com/homirun/fluent-plugin-num-comparison/actions/workflows/test.yaml)

fluent-plugin-num-comparison is a fluent-plugin that compares the value of a specified key with a threshold value and extracts only the larger or smaller ones.


## Installation

### RubyGems
```
$ gem install fluent-plugin-num-comparison
```

### Bundler

Add following line to your Gemfile:

```ruby
gem "fluent-plugin-num-comparison"
```

And then execute:

```
$ bundle
```

## Configuration

### InputExample
```json
{"access_count": 29}
{"access_count": 30}
{"access_count": 31}
```

### ConfigExample
```
<source>
  @type tail
  path input.txt
  pos_file input.pos
  format json
  tag test
</source>

<filter test>
  @type num_comparison
  record_key access_count
  threshold 30
  inequality larger
</filter>

<match test>
  @type stdout
</match>

```

### OutputExample
```json
{"access_count": 31}
```

## Params
- record_key: string  
  The key of the event record to be compared.
  
- threshold: integer  
  The threshold value to compare with the event record.
- inequality: string (`larger` || `smaller`)  
  Decide whether to output a comparison object that is larger or smaller than the threshold.
  The default value is `larger`.  


## Copyright

* Copyright(c) 2021- homirun
* License
  * MIT
