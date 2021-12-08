require "helper"
require "fluent/plugin/filter_num_comparison.rb"

class NumComparisonFilterTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  sub_test_case 'filter' do
    test 'If inequality-property is <larger> and the value is larger than the threshold, do not delete record.' do
      config = %[
          inequality larger
          record_key count
          threshold 10
        ]
      d = create_driver(config)
      data = d.run(default_tag: 'test') do
        d.feed(event_time,
               {
                 "count" => "11"
               })
      end
      assert_equal 1, data.count
    end

    test 'If inequality-property is <larger> and the value is smaller than the threshold, delete record.' do
      config = %[
          inequality larger
          record_key count
          threshold 10
        ]
      d = create_driver(config)
      data = d.run(default_tag: 'test') do
        d.feed(event_time,
               {
                 "count" => "9"
               })
      end
      assert_equal 0, data.count
    end

    test 'If inequality-property is <smaller> and the value is smaller than the threshold, do not delete record.' do
      config = %[
          inequality smaller
          record_key count
          threshold 10
        ]
      d = create_driver(config)
      data = d.run(default_tag: 'test') do
        d.feed(event_time,
               {
                 "count" => "9"
               })
      end
      assert_equal 1, data.count
    end

    test 'If inequality-property is <smaller> and the value is larger than the threshold, delete record.' do
      config = %[
          inequality smaller
          record_key count
          threshold 10
        ]
      d = create_driver(config)
      data = d.run(default_tag: 'test') do
        d.feed(event_time,
               {
                 "count" => "11"
               })
      end
      assert_equal 0, data.count
    end

    test 'if the value is equal to the threshold, delete record.' do
      config = %[
          inequality smaller
          record_key count
          threshold 10
        ]
      d = create_driver(config)
      data = d.run(default_tag: 'test') do
        d.feed(event_time,
               {
                 "count" => "10"
               })
      end
      assert_equal 0, data.count
    end
  end

  def create_driver(conf)
    Fluent::Test::Driver::Filter.new(Fluent::Plugin::NumComparisonFilter).configure(conf)
  end
end
