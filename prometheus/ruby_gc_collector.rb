# frozen_string_literal: true

require 'prometheus/client'

class SimpleObject
  def initialize(value)
    @val = value
  end
end

prometheus = Prometheus::Client.registry
bytes_gauge = Prometheus::Client::Gauge.new(:ruby_heap_memory_bytes_counter, docstring: 'A counter of allocated heap memory')
prometheus.register(bytes_gauge)

objects = []
loop do
  allocated_bytes = GC.stat[:malloc_increase_bytes]  
  bytes_gauge.set(allocated_bytes)
  objects << SimpleObject.new(('a'..'z').to_a.sample)
  sleep(1)
end
