require 'rubygems'
require 'coffee-script'
require 'haml'
require 'sass'
require 'bourbon'
require 'fileutils'

convert_extensions = %w(coffee haml sass)

task :dir do
  FileUtils.mkdir_p 'public'
end

task :coffee do
  Dir.glob "source/*.coffee" do |file|
    print "Compiling #{file}..."
    target = File.open('public/' + File.basename(file).split('.coffee')[0] + '.js', 'w')
    target.write CoffeeScript.compile(File.read(file))
    target.close
    puts " done!"
  end
end

task :haml do
  Dir.glob "source/*.haml" do |file|
    print "Compiling #{file}..."
    target = File.open('public/' + File.basename(file).split('.haml')[0] + '.html', 'w')
    target.write Haml::Engine.new(File.read(file)).render
    target.close
    puts " done!"
  end
end

task :sass do
  FileUtils.cd 'source' do
    Bourbon::Generator.new(['install']).run
  end

  Dir.glob "source/*.sass" do |file|
    print "Compiling #{file}..."
    target = 'public/' + File.basename(file).split('.sass')[0] + '.css'
    Sass.compile_file(file, target)
    puts " done!"
  end

  FileUtils.rm_rf %w(source/bourbon .sass-cache)
end

task :copy do
  Dir.glob "source/*.*" do |file|
    unless File.directory?(file) or convert_extensions.include?(file.split('.')[-1])
      FileUtils.cp file, 'public/' + File.basename(file)
    end
  end
end

task :clean do
  FileUtils.rm_rf %w(public/ source/bourbon .sass-cache)
end

task :run => %w(dir coffee haml sass copy)
task :fresh => %w(clean run)
task :default => :run
