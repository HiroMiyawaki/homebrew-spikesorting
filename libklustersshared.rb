require 'formula'

class Libklustersshared < Formula
  homepage 'http://klusters.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/neurosuite/sources/libklustersshared-2.0.0.tar.gz'
  sha1 'f36cb3404c589cc79fcfc961633b1d626a4a7fa1'

  head 'http://git.code.sf.net/p/klusters/libklustersshared', :using =>  :git

  depends_on 'cmake' => :build
  depends_on 'qt'

  option 'with-debug', 'Build with debug symbols'

  env :std
  
  def install
    if build.with? 'debug'
      # Debug symbols need to find the source so build in the prefix
      cp_r "#{pwd}", "#{prefix}/src"
      cd "#{prefix}/src"

      # Set build to release with debug symbols
      ENV.append "CXXFLAGS", "-g -O2"
    end

    system "cmake", ".", *std_cmake_args
    system "make install"
  end
end
