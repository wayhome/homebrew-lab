require 'formula'

class Wish < Formula
  homepage 'http://zhihu.com'
  head 'git@github.com:ZhihuDev/wish.git', :using => :git

  def install
    system "./configure"
    system "make"
    system "make install"
  end
end
