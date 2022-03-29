def get_command_line_argument
  # ARGV is an array that Ruby defines for us,
  # which contains all the arguments we passed to it
  # when invoking the script from the command line.
  # https://docs.ruby-lang.org/en/2.4.0/ARGF.html
  if ARGV.empty?
    puts "Usage: ruby lookup.rb <domain>"
    exit
  end
  ARGV.first
end

# `domain` contains the domain name we have to look up.
domain = get_command_line_argument

# File.readlines reads a file and returns an
# array of string, where each element is a line
# https://www.rubydoc.info/stdlib/core/IO:readlines
dns_raw = File.readlines("zone")

# ..
# ..
# FILL YOUR CODE HERE
# ..
# ..

def parse_dns(dns_raw)
  dns_records = []
  dns_raw = dns_raw.select { |line| line[0] != "#" && line.strip.length != 0 }
  dns_raw.each do |record|
    cols = record.split(",").map { |col| col.strip }
    dns_entry_type = cols.first.to_sym
    domain = cols[1]
    entry = {}
    if dns_entry_type == :A
      ip = cols.last
      entry = {
        :type => dns_entry_type,
        :domain => domain,
        :ip => ip,
      }
    elsif dns_entry_type == :CNAME
      entry = {
        :type => dns_entry_type,
        :domain => domain,
        :alias => cols.last,
      }
    end
    dns_records.push(entry)
  end
  dns_records
end

def resolve(dns_records, lookup_chain, domain)
  entries = dns_records.select { |record|
    record[:domain] == domain
  }
  if entries.length == 0
    lookup_chain.push("Error: record not found for #{domain}")
    return lookup_chain
  end
  first_record = entries.first
  if first_record[:type] == :A
    lookup_chain.push(first_record[:ip])
  elsif first_record[:type] == :CNAME
    lookup_chain.push(first_record[:domain])
    resolve(dns_records, lookup_chain, first_record[:alias])
  end
end

# To complete the assignment, implement `parse_dns` and `resolve`.
# Remember to implement them above this line since in Ruby
# you can invoke a function only after it is defined.
dns_records = parse_dns(dns_raw)
lookup_chain = [domain]
lookup_chain = resolve(dns_records, lookup_chain, domain)
puts lookup_chain.join(" => ")
