require "helper"
require "fluent/plugin/filter_num_comparison.rb"

class NumComparisonFilterTest < Test::Unit::TestCase
  setup do
    Fluent::Test.setup
  end

  test "failure" do
    flunk
  end

  private

  def create_driver(conf)
    Fluent::Test::Driver::Filter.new(Fluent::Plugin::NumComparisonFilter).configure(conf)
  end
end
