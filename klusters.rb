require 'formula'

class Klusters < Formula
  homepage 'http://klusters.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/neurosuite/sources/klusters-2.0.0.tar.gz'
  sha256 '4bda00e942b21a92d5f8cb5db85f4936be1af06dcfac81dd9f0388268e38a24b'

  head 'http://git.code.sf.net/p/klusters/klusters', :using => :git

  depends_on 'cmake' => :build
  depends_on 'qt5'
  depends_on 'libklustersshared'

  option 'with-debug', 'Build with debug symbols'

  env :std

  def install
    if build.with? 'debug'
      # Debug symbols need to find the source so build in the prefix
      cp_r "#{pwd}", "#{prefix}/src"
      cd "#{prefix}/src"

      # Set build type to release with debug symbols
      ENV.append "CXXFLAGS", "-g -O2"
    end

    system "cmake", ".", *std_cmake_args 
    system "make install"
  end
end
