require_relative 'lib/street_address'

# Take a string address and parse it.  Measure (roughly) how long it takes.
# Input:
# => addr (string)
def simple_benchmark(addr)
  beginning_time = Time.now
  street_addr = StreetAddress::US.parse(addr)
  end_time = Time.now
  total_milli = ((end_time - beginning_time) * 100).round(5)
  time_text = "#{total_milli}".ljust(26)
  puts "#{time_text} #{addr}"
end

# Lets benchmark then addresses found within the tests
addr1 = "2730 S Veitch St Apt 207, Arlington, VA 22206"
addr2 = "44 Canal Center Plaza Suite 500, Alexandria, VA 22314"
addr3 = "1600 Pennsylvania Ave Washington DC"
addr4 = "1005 Gravenstein Hwy N, Sebastopol CA 95472"
addr5 = "PO BOX 450, Chicago IL 60657"
addr6 = "2730 S Veitch St #207, Arlington, VA 22206"
int1 = "Hollywood & Vine, Los Angeles, CA"
int2 = "Hollywood Blvd and Vine St, Los Angeles, CA"
int3 = "Mission Street at Valencia Street, San Francisco, CA"

puts
puts "Time (in milliseconds)     Address"
puts "================================================================================="

# Run through our simple benchmarking method
simple_benchmark(addr1)
simple_benchmark(addr2)
simple_benchmark(addr3)
simple_benchmark(addr4)
simple_benchmark(addr5)
simple_benchmark(addr6)
simple_benchmark(int1)
simple_benchmark(int2)
simple_benchmark(int3)

puts