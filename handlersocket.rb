require 'formula'
require 'tmpdir'

class Handlersocket < Formula
  url 'https://github.com/youngking/HandlerSocket-Plugin-for-MySQL/zipball/1.2-dev'
  homepage 'https://github.com/DeNADev/HandlerSocket-Plugin-for-MySQL'
  md5 '985118b6d18e843e09fe8951188d4997'

  MYSQL_VERSION = '5.5.25a'

  depends_on 'mysql'

  def extract_mysql
    tarball = File.join HOMEBREW_CACHE, "mysql-#{MYSQL_VERSION}.tar.gz"
    raise unless FileTest.exist? tarball
    Dir.chdir mysql_source_dir do
      safe_system "/usr/bin/tar", "xf", tarball
    end
  end

  def mysql_source_dir
    unless @mysql_source_dir
      @mysql_source_dir = Dir.mktmpdir 'handlersocket'
      # at_exit{ FileUtils.remove_entry_secure @mysql_source_dir }
    end
    @mysql_source_dir
  end

  def install
    extract_mysql
    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}", "--with-mysql-source=#{mysql_source_dir}/mysql-#{MYSQL_VERSION}",
                          "--with-mysql-bindir=#{HOMEBREW_PREFIX}/bin", #"--with-mysql-plugindir=#{HOMEBREW_PREFIX}/Cellar/mysql/#{MYSQL_VERSION}/lib/plugin"
                          "--with-mysql-plugindir=$(brew --prefix mysql)/lib/plugin"
    system "make"
    system "make install"
  end
end
