require 'formula'

class Kids < Formula
  homepage 'http://zhihu.com'
  head 'git@github.com:ZhihuDev/Kids.git', :using => :git

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
    etc.install 'samples/server.conf' => "kids.conf"
  end

  def caveats
    <<-EOS.undent
    If this is your first install, automatically load on login with:
        mkdir -p ~/Library/LaunchAgents
        cp #{plist_path} ~/Library/LaunchAgents/
        launchctl load -w ~/Library/LaunchAgents/#{plist_path.basename}

    If this is an upgrade and you already have the #{plist_path.basename} loaded:
        launchctl unload -w ~/Library/LaunchAgents/#{plist_path.basename}
        cp #{plist_path} ~/Library/LaunchAgents/
        launchctl load -w ~/Library/LaunchAgents/#{plist_path.basename}

      To start kids manually:
        kids -c #{etc}/kids.conf

      To access the server:
        redis-cli -p 3388
    EOS
  end

  def startup_plist
    return <<-EOPLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>KeepAlive</key>
    <true/>
    <key>Label</key>
    <string>#{plist_name}</string>
    <key>ProgramArguments</key>
    <array>
      <string>#{HOMEBREW_PREFIX}/bin/kids</string>
      <string>-c</string>
      <string>#{etc}/kids.conf</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>UserName</key>
    <string>#{`whoami`.chomp}</string>
    <key>WorkingDirectory</key>
    <string>#{var}</string>
    <key>StandardErrorPath</key>
    <string>#{var}/log/kids.log</string>
    <key>StandardOutPath</key>
    <string>#{var}/log/kids.log</string>
  </dict>
</plist>
    EOPLIST
  end

end
