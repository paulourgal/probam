# A sample Guardfile
# More info at https://github.com/guard/guard#readme
guard 'rspec', cmd: "rspec" do
  # watch /lib/ files
  watch(%r{^lib/(.+).rb$}) do |m|
    "spec/#{m[1]}_spec.rb"
  end

# watch /spec/ files
  watch(%r{^spec/(.+).rb$}) do |m|
    "spec/#{m[1]}.rb"
  end
end
