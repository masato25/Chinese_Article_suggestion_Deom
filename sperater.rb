File.open("list_sample","r").read.each_line{|l|
    puts l.rpartition("")
}