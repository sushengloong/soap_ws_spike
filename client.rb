#!/usr/bin/env ruby

require 'savon'
require 'active_support/core_ext/hash/conversions'

WSDL_URI = 'http://localhost:3000/users/wsdl'

def print_result operation, result
  puts "--------RAW---------"
  puts result
  puts "--------------------"

  begin
    puts Hash.from_xml(result.to_hash["#{operation}_response".to_sym][:value])
  rescue => e
    puts "Unable to parse result: #{e.message}"
  end
end

client = Savon::Client.new(wsdl: WSDL_URI)

puts "-----OPERATIONS-----"
puts client.operations
puts "--------------------"

result = client.call(:list, message: {})
print_result :list, result

result = client.call(:create, message: {username: 'mikasa', fullname: 'Mikasa Ackerman', email: 'mikasa@attackontitan.com', role: 'soldier'})
print_result :create, result

result = client.call(:list, message: {})
print_result :list, result
