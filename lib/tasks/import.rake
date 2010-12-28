basedir = "/home/textmi/import"

task :import => :environment do
  puts 'importing begins...'
  #puts Text.all
  Dir.chdir(basedir)
  contains = Dir['**/*.*']
  contains.each do |entry|
    if File.file? entry
      fn = entry.split('/')[-1]
      path = entry.split('/')
      path.delete(path[-1])
      ext = entry.split('/')[-1].split('.')[-1]
      jfn = fn.split('.')
      jfn.delete(ext)
      p jfn.join(' ') +" is a "+ext.upcase+" file, and it's path is: "+basedir+"/"+entry
      image = Image.new()
      image.photo = File.new(basedir+"/"+entry)
      text = Text.new()
      text.name = jfn.join(' ')
      text.user_id = 1
      text.tag_list = path.join(',')
      text.save()
      image.text_id = text.id
      image.save()
      p 'saved image #'+image.id.to_s+' with text #'+text.id.to_s
    end
  end
  puts 'Shalom'
end

