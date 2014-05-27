require "rubygems"
require 'clamp'
require 'typhoeus'
require 'json'

module DataCenterApi
  class Cluster
    attr_accessor :base_url, :machines

    def initialize(url)
      @base_url = /http:\/\/localhost:[0-9]{4}/.match(url)[0]
      @machines = get_machines
    end

    def get_machines
      hydra = Typhoeus::Hydra.new
      request = Typhoeus::Request.new(@base_url)
      @machine_entries = []
      request.on_complete do |response|
        JSON.parse(response.body).each_pair do |id, url|
          id = Typhoeus::Request.new(url)
          id.on_complete { |response| @machine_entries << JSON.parse(response.body) }
          hydra.queue(id)
        end
      end

      hydra.queue(request)
      hydra.run
      return @machine_entries
    end

    def num_machines_with(metric_id)
      machines.find_all{|hash| hash["metrics"].has_key?(metric_id)}.count
    end

    def min_num_machines_with(metric_id)
      machines.min_by{|hash| hash["metrics"][metric_id]}
    end

    def max_num_machines_with(metric_id)
      machines.max_by{|hash| hash["metrics"][metric_id]}
    end

    def min_max_std_deviation_for(nums=[])          
      mean = nums.reduce(:+).to_f / nums.length                 # Find the mean number        
      dev_sq = nums.map do |n|                                  # For every number
        dev = n - mean                                          # Calculate deviation 
        dev * dev                                               # Sqaure the deviation
      end                                                       # Sum the sqaured_deviation nums
      div_sum_dev_sq = dev_sq.reduce(:+) / (nums.length - 1)    # and divide by num of items in the original list 
      Math.sqrt(div_sum_dev_sq).round(2)                        # Find the square root of the result.
    end
  end

  class Machine
    attr_accessor :metrics

    def initialize(url)
      data = JSON.parse(Typhoeus::Request.get(url).body)
      @metrics = data["metrics"]
      @id = data["id"]
    end
  end

  class App < Clamp::Command
    option "--url", :url, "URL of web api"
    attr_accessor :cluster, :machine

    def execute
      @cluster = Cluster.new(url)
      @machine = Machine.new(url)
      get_reading
    end

    def get_reading
      @machine.metrics.each_pair do |metric_id, value|
        nums = [@cluster.min_num_machines_with(metric_id)["metrics"][metric_id]]
        nums << @cluster.max_num_machines_with(metric_id)["metrics"][metric_id]
        puts "METRIC: #{metric_id}"
        puts "NUM: #{@cluster.num_machines_with(metric_id)}"
        puts "MINIMUM: #{@cluster.min_num_machines_with(metric_id)["id"]}"
        puts "MAXIMUM: #{@cluster.max_num_machines_with(metric_id)["id"]}"
        puts "STD: #{@cluster.min_max_std_deviation_for(nums)}\n\n"
      end
    end

  end
end
