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



   inreplace 'src/gui/qhelpviewer.cpp' do |s|
      s.gsub! '#include <QWebView>', '#include <QtWebEngineWidgets>' 
      s.gsub! '#include <QWebEnginePage>', '' 
   #   s.gsub! 'QWebView', 'QWebEngineView' 
   #   s.gsub! 'QWebPage', 'QWebEnginePage'
   #   s.gsub! 'mView->page()'  '//mView->page()'
   end    

    inreplace 'src/CMakeLists.txt','add_library (klustersshared SHARED ${libklustersshared_SRCS} ${translateSrcs})', "add_library \(klustersshared SHARED \$\{libklustersshared_SRCS\} \$\{translateSrcs\}) \n QT5_USE_MODULES\(klustersshared WebEngineWidgets\)"

    inreplace 'src/gui/qhelpviewer.h' do |s|
      s.gsub! 'QWeb', 'QWebEngine' 
    end    

    system "cmake" , ".", "-DENFORCE_QT4_BUILD=OFF", *std_cmake_args
    system "make install"
  end
end
