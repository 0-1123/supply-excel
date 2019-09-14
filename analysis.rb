require 'csv'

csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'www_data.csv'

suppliers_numbers = {}
CSV.foreach(filepath, csv_options) do |row|
  if suppliers_numbers["#{row['VendorID']}"].nil?
    suppliers_numbers["#{row['VendorID']}"] = 1
  else
    suppliers_numbers["#{row['VendorID']}"] += 1
  end
end

puts "VendorID with number of invoices:"
puts suppliers_numbers.sort_by { |key, value| value}.to_h

suppliers_value = Hash.new(0)
num = 0
CSV.foreach(filepath, csv_options) do |row|
  if suppliers_value["#{row['VendorID']}"].nil?
    suppliers_value["#{row['VendorID']}"] = row['Invoice_Value'].gsub("€", "").gsub(" ", "").gsub(",", "").to_f
  else
    suppliers_value["#{row['VendorID']}"] += row['Invoice_Value'].gsub("€", "").gsub(" ", "").gsub(",", "").to_f
  end
end

puts "VendorID with total value of invoices:"
puts suppliers_value.sort_by { |key, value| value}.to_h
