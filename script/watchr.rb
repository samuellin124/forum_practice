puts "\n### Watching specs and features ... ###\n"

def run_all_specs
  system("bundle exec rspec spec")
  puts
end
 
def run_spec(file)
  if File.exist?(file)
    puts "Running #{file}"
    system("bundle exec rspec #{file}")
    puts
  else
    puts "#{file} does not exist"
    return
  end
end

def run_feature(feature)
  puts "Running #{feature}"
  system "bundle exec cucumber #{feature}"
end

def run_all_features
  puts 'Running all features'
  system 'rake cucumber'
end

watch('^app/(.*)\.rb') {|md| run_spec("spec/#{md[1]}_spec.rb") } 
watch('^app/views\/(.*)') {|md| run_spec("spec#{md[0].gsub!(/^app/, '')}_spec.rb")}
watch('^lib/(.*)\.rb') {|md| run_spec("spec/lib/#{md[1]}_spec.rb")}

watch('^spec\/.*\/.*_spec\.rb') {|md| run_spec(md[0]) }
watch('^spec/factories/(.*)\.rb') { |md| run_spec("spec/models/#{md[1]}_spec.rb") }
watch('spec/spec_helper.rb') {|md| run_all_specs }

watch('^features/(.*)\.feature') { |feature| run_feature(feature[0]) }
watch('features/support/env.rb') { |cucumber| run_all_features }

# Ctrl-\
Signal.trap('QUIT') do
 puts "\n### Running all specs and features ###\n"
 run_all_specs
 #run_all_features
end
       
# Ctrl-C
Signal.trap('INT') { abort("\n") }