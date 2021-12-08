#
# Copyright 2021- homirun
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "fluent/plugin/filter"

module Fluent
  module Plugin
    class NumComparisonFilter < Fluent::Plugin::Filter
      Fluent::Plugin.register_filter("num_comparison", self)

      config_param :record_key, :string
      config_param :threshold, :integer
      # larger or smaller
      config_param :inequality, :string, default: "larger"

      def configure(conf)
        super
        @record_key = @record_key.to_s
        @threshold = @threshold.to_i
        @inequality_flag = @inequality == "smaller" ? 0 : 1
      end

      def filter_stream(tag, es)
        new_es = Fluent::MultiEventStream.new
        es.each do |time, record|
          if @inequality_flag == 0
            if record[@record_key].to_i < @threshold
              new_es.add(time, record)
            end
          else
            if record[@record_key].to_i > @threshold
              new_es.add(time, record)
            end
          end
        end
        new_es
      end
    end
  end
end
