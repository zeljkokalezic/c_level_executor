require 'inline'

Inline::C.class_eval do
  def load
    #p '### Monkey Patch ###'
    require "#{so_name}"# or raise LoadError, "require on #{so_name} failed"
    clean_up
  end

  def clean_up
    FileUtils.rm_f("#{Inline.directory}/#{module_name}.#{RbConfig::CONFIG["DLEXT"]}")
    FileUtils.rm_f("#{Inline.directory}/#{module_name}.#{RbConfig::CONFIG["DLEXT"]}.dSYM")
    FileUtils.rm_f("#{Inline.directory}/#{module_name}.c")
  end
end