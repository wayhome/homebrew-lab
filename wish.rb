require 'formula'

class Wish < Formula
  homepage 'http://zhihu.com'
  url 'https://github.com/ZhihuDev/wish.git', :tag => 'v0.2.2'
  version 'v0.2.2'
  head 'git@github.com:ZhihuDev/wish.git', :using => :git

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
    (prefix+'etc/bash_completion.d').install "bash-completion/wish" => "wish"
  end
end
