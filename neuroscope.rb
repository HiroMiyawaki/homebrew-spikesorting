require 'formula'

class Neuroscope < Formula
  homepage 'http://neuroscope.sourceforge.net/'
  head 'http://git.code.sf.net/p/neuroscope/code', :using => :git

  depends_on 'cmake' => :build
  depends_on 'qt'
  depends_on 'libklustersshared'

  def install
    system "cmake", ".", *std_cmake_args
    system "make install"
  end
end
