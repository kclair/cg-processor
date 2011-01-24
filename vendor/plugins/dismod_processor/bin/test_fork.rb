require 'ftools'
require 'getoptlong'

def openfiles(path)
  File.makedirs(path)
  ret = []
  1.upto(5) do |i|
    ret << File.open(File.join(path, i.to_s), 'a')
  end
  return ret
end

def closefiles(files)
  files.each do |f|
    f.close
  end
end



opts = GetoptLong.new(
  [ '--out', '-o', GetoptLong::REQUIRED_ARGUMENT ],
  [ '--err', '-e', GetoptLong::REQUIRED_ARGUMENT ]
)

stdout_dir = nil
stderr_dir = nil
opts.each do |opt, arg|
  case opt
    when '--out'
      stdout_dir = arg
    when '--err'
      stderr_dir = arg 
  end
end

exit 0 if !stdout_dir and !stderr_dir

3.times do
  stdout_files = openfiles(stdout_dir)
  stderr_files = openfiles(stderr_dir)
  stdout_files.each do |f|
    f.write('hello to stdout at '+Time.now.to_s+"\n")
  end
  stderr_files.each do |f|
    f.write("hello to stderr at "+Time.now.to_s+"\n")
  end
  sleep 3
  closefiles(stdout_files)
  closefiles(stderr_files)
end

