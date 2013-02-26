require 'formula'

class Wish < Formula
  homepage 'http://zhihu.com'
  url 'http://git.in.zhihu.com/infrastructure/wish.git', :tag => 'v0.2.4'
  version 'v0.2.4'
  head 'git@git.in.zhihu.com:infrastructure/wish.git', :using => :git

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make install"
    (prefix+'etc/bash_completion.d').install "bash-completion/wish" => "wish"
  end
end
