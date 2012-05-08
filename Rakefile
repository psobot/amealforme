require 'coffee-script'
require 'sass'
require 'bourbon'
require 'fileutils'

extensions = ['js', 'css', 'html', 'json', 'jpg', 'png']

task :run do

  Dir.glob "source/*.coffee" do |file|
    print "Compiling #{file}..."
    target = File.open('public/' + File.basename(file).split('.coffee')[0] + '.js', 'w')
    target.write CoffeeScript.compile(File.read(file))
    target.close
    puts " done!"
  end

  Dir.glob "source/*.sass" do |file|
    print "Compiling #{file}..."
    target = 'public/' + File.basename(file).split('.sass')[0] + '.css'
    Sass.compile_file(file, target)
    puts " done!"
  end

  FileUtils.cd 'source' do
    Bourbon::Generator.new(['install']).run
  end

  extensions.each do |ext|
    Dir.glob "source/*.#{ext}" do |file|
      FileUtils.cp file, 'public/' + File.basename(file)
    end
  end

end

task :clean do
  extensions.each do |ext|
    FileUtils.rm Dir.glob("public/*.#{ext}")
  end
  FileUtils.rm_rf 'source/bourbon'
  FileUtils.rm_rf '.sass-cache'
end

task :default => :run
