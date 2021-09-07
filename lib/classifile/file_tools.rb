class FileTools
  @@copy = false

  def self.get_file_list(_path)
    ex_path = File.expand_path(_path)
    virtual = !File.exist?(ex_path)
    if virtual
      dir =File.expand_path(File.dirname(_path).to_s) # for Windows
      file = File.basename(ex_path).to_s
      path = File.join(dir,file)
      Dir.glob(path)
    else
      ftype = File::ftype(ex_path)
      if ftype =="directory"
        Dir.glob(File.join(ex_path,"*"))
      else
        [ex_path]
      end

    end
  end

  def self.move(src,dest,options = {})
    dir =File.dirname(dest).to_s
    FileUtils.mkpath(dir)

    if @@copy
      FileUtils.copy(src, dest,**options)
    else
      FileUtils.move(src, dest,**options)
    end
  end

  def self.copy_mode
    @@copy = true
  end
end