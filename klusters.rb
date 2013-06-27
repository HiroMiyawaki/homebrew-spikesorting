require 'formula'

class Klusters < Formula
  homepage 'http://klusters.sourceforge.net/'
  head 'http://git.code.sf.net/p/klusters/klusters', :using => :git

  depends_on 'cmake' => :build
  depends_on 'qt'
  depends_on 'libklustersshared'

  def install
    system "cmake", ".", *std_cmake_args
    system "make install"
  end
end
