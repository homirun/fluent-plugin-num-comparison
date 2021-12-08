# fluent-plugin-num-comparison

[Fluentd](https://fluentd.org/) filter plugin to do something.

指定したキーの値と閾値を比較して大きい、もしくは小さいものだけを抽出するプラグインです。

## Installation

### RubyGems
#### gemに登録していないので降ってきません

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
{"access_count": 29},
{"access_count": 30},
{"access_count": 31},
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
{"access_count": 30},
{"access_count": 31},
```

## Params
- record_key: string  
  比較したいレコードのキー  
- threshold: integer  
  閾値  
- inequality: string (`larger` || `smaller`)  
  比較対象が閾値より大きいものをアウトプットするのか小さいものをアウトプットするのかを決める  
  デフォルト値は`larger`  


## Copyright

* Copyright(c) 2021- homirun
* License
  * Apache License, Version 2.0
