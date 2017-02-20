require 'formula'

class Libklustersshared < Formula
  homepage 'http://klusters.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/neurosuite/sources/libklustersshared-2.0.0.tar.gz'
  sha256 '560d0c820e469fa054a65a40f1cd95eb99b812e677f87afafaf1b503dfcfbd35'

  head 'http://git.code.sf.net/p/klusters/libklustersshared', :using =>  :git

  depends_on 'cmake' => :build
  depends_on 'qt5'

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

    system "cmake" , ".", "-DENFORCE_QT4_BUILD=OFF", *std_cmake_args

    inreplace 'src/gui/*' do |s|
      s.gsub! 'QWeb', 'QWebEngine' 
    end    

    system "make install"
  end
end
