require 'formula'

class Libklustersshared < Formula
  homepage 'http://klusters.sourceforge.net/'
  head 'http://git.code.sf.net/p/klusters/libklustersshared', :using =>  :git

  depends_on 'cmake' => :build
  depends_on 'qt'

  def install
    system "cmake", ".", *std_cmake_args
    system "make install"
  end
end
