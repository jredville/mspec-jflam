# The #tmp method provides a similar functionality
# to that of Dir.tmpdir. This helper can be overridden
# by different implementations to provide a more useful
# behavior if needed.
#
# Usage in a spec:
#
#   File.open(tmp("tags.txt"), "w") { |f| f.puts "" }
#
# The order of directories below with "/private/tmp"
# preceding "/tmp" is significant. On OS X, the directory
# "/tmp" is a symlink to "private/tmp" with no leading
# "/". Rather than futzing with what constitutes an
# absolute path, we just look for "/private/tmp" first.

class Object
  def tmp(name)
    unless @spec_temp_directory
      # Respect environment variables before guessing. Use home directory last.
      # Windows interprets /tmp as C:\tmp, which isn't writeable, but Ruby
      # doesn't recognize that.
      [  ENV["TMPDIR"], ENV["TMP"], ENV["TEMP"], 
         "/private/tmp", "/tmp", "/var/tmp",
         ENV["USERPROFILE"] ].each do |dir|
        if dir and File.directory?(dir) and File.writable?(dir)
          temp = File.expand_path dir
# IronRuby doesn't have File.readlink and File.symlink? implemented yet
#          temp = File.readlink temp if File.symlink? temp
          @spec_temp_directory = temp
          break
        end
      end
    end

    File.join @spec_temp_directory, name
  end
end
