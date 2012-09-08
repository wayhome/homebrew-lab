require 'formula'

class Wish < Formula
  homepage 'http://zhihu.com'
  url 'https://github.com/ZhihuDev/wish.git', :tag => 'v0.1.3'
  version 'v0.1.3'
  head 'git@github.com:ZhihuDev/wish.git', :using => :git

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
  end
end
