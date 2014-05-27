require File.dirname(__FILE__) + '/../lib/app' 
require 'rspec'

describe "DataCenterApi" do

  describe "Cluster" do
    subject { DataCenterApi::Cluster.new(url) }

    context "has a base_url" do
      let(:url) { "http://localhost:9292/metrics/machine_1" }
      its(:base_url) { should_not eq(:url)}
      its(:base_url) { should eq("http://localhost:9292")}
    end

    context "get machines" do
      let(:url) { "http://localhost:9292/metrics/machine_1" }
      its(:machines) { should be_a(Array) }
      its(:machines) { should have(5).items }
    end

  end

  describe "Machine" do
    subject { DataCenterApi::Machine.new(url) }

    context "metrics" do
      let(:url) { "http://localhost:9292/metrics/machine_1" }
      its(:metrics) { should be_a(Hash) }
      its(:metrics) { should have(2).items }
      its(:metrics) { should include("metric_1") }
      its(:metrics) { should include("metric_2") }
    end
  end

  describe "App" do
    subject { DataCenterApi::App.new(url) }

    context "gets machine cluster" do
      let(:url) { "http://localhost:9292/metrics/machine_1" }
      its(:cluster) { should be_an(Object)}
    end

    context "gets machine" do
      let(:url) { "http://localhost:9292/metrics/machine_1" }
      its(:machine) { should be_an(Object)}
    end
  end

end