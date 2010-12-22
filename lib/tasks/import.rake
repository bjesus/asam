basedir = "/home/bjesus/Desktop/texts"

task :import => :environment do
  puts 'importing begins...'
  #puts Text.all
  Dir.chdir(basedir)
  contains = Dir['**/*.*']
  contains.each do |entry|
    #p entry
    fn = entry.split('/')[-1]
    ext = entry.split('/')[-1].split('.')[-1]
    jfn = fn.split('.')
    jfn.delete(ext)
    p jfn.join(' ') +" is a "+ext.upcase+" file, and it's path is: "+basedir+"/"+entry
  end
  puts 'Shalom'
end

