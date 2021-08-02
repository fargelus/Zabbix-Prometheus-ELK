# frozen_string_literal: true

require 'prometheus_exporter'
require 'prometheus_exporter/server'
require 'prometheus_exporter/client'
require 'prometheus_exporter/instrumentation'

server = PrometheusExporter::Server::WebServer.new bind: 'localhost', port: 12345
server.start
PrometheusExporter::Client.default = PrometheusExporter::LocalClient.new(collector: server.collector)

bytes_gauge = PrometheusExporter::Metric::Gauge.new("ruby_heap_memory_bytes_counter", "A counter of allocated heap memory")
server.collector.register_metric(bytes_gauge)

SimpleStruct = Struct.new(:value)

objects = []
loop do
  allocated_bytes = GC.stat[:malloc_increase_bytes]
  bytes_gauge.observe(allocated_bytes)
  objects << SimpleStruct.new(('a'..'z').to_a.sample)
  sleep(1)
end
