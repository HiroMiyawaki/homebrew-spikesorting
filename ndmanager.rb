require 'formula'

class Ndmanager < Formula
  homepage 'http://ndmanager.sourceforge.net/'
  head 'http://git.code.sf.net/p/ndmanager/code', :using => :git

  depends_on 'cmake' => :build
  depends_on 'qt'
  depends_on 'libklustersshared'

  def install
    if build.head?
      system "cd ndmanager"
    end
    system "cmake", ".", *std_cmake_args
    system "make install"
  end
end
