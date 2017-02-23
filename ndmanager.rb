require 'formula'

class Ndmanager < Formula
  homepage 'http://ndmanager.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/neurosuite/sources/ndmanager-2.0.0.tar.gz'
  sha256 'd2be3043854e15e878af87124f1e0611b64b48f004ac975a97e1d9d0d4b767a6'

  head 'http://git.code.sf.net/p/ndmanager/code', :using => :git

  depends_on 'cmake' => :build
  depends_on 'qt5'
  depends_on 'libklustersshared'

  option 'with-debug', 'Build with debug symbols'

  env :std

  def install

    if build.head?
      system "cd ndmanager"
    end

    if build.with? 'debug'
      # Debug symbols need to find the source so build in the prefix
      cp_r "#{pwd}", "#{prefix}/src"
      cd "#{prefix}/src"

      # Set build to release with debug symbols
      ENV.append "CXXFLAGS", "-g -O2"
    end

   inreplace 'src/queryoutputdialog.h' do |s|
      s.gsub! '#include <QWebView>', '#include <QtWebEngineWidgets>' 
      s.gsub! 'QWebView', 'QWebEngineView' 
   end

   inreplace 'src/queryoutputdialog.cpp' do |s|
      s.gsub! '#include <QWebSettings>', '' 
      s.gsub! 'QWebSettings', 'QWebEngineSettings' 
      s.gsub! 'QWebView','QWebEngineView'
      s.gsub! 'html->settings()->setAttribute(QWebEngineSettings::JavaEnabled,false);',''

   end   
  
   inreplace 'src/ndmanagerdoc.cpp','QString path = QStandardPaths::locate (QStandardPaths::ApplicationsLocation, QLatin1String("ndmanager/ndManagerDefault.xml"))', 'QString path = QStandardPaths::locate (QStandardPaths::ApplicationsLocation, QLatin1String("/usr/local/share/ndmanager/ndManagerDefault.xml"))'

   inreplace 'src/CMakeLists.txt','add_executable(ndmanager WIN32 ${ndmanager_SRCS} )',"add_executable(ndmanager WIN32 ${ndmanager_SRCS} )\nQT5_USE_MODULES(ndmanager WebEngineWidgets)"



    system "cmake", ".", "-DENFORCE_QT4_BUILD=OFF", *std_cmake_args
    system "make install"
  end
end
