require 'formula'

class NdmanagerPlugins < Formula
  homepage 'http://ndmanager.sourceforge.net/'
  url 'https://sourceforge.net/projects/neurosuite/files/sources/ndmanager-plugins-1.4.14.tar.gz'
  sha256 'f541bfc1e4d9ad7f2ab6523b2a5664265cf6ae4cd55517de2fa9c4fc6bb50a90'

  depends_on 'docbook-xsl' => :build
  depends_on "pkg-config" => :build

  depends_on :python
  depends_on 'sdl'
  depends_on 'gsl'
  depends_on 'libsamplerate'
  depends_on 'pyqt5'


  
  def install

#    # Make sure sdl, gsl are found.
#    inreplace 'src/process_pca/makefile' do |s|
#      s.gsub! '-L/usr/lib'    , "-L#{HOMEBREW_PREFIX}/lib"
#      s.gsub! '-I/usr/include', "-I#{HOMEBREW_PREFIX}/include"
#    end
#
#    # Make sure pyqt is found
#    inreplace 'python/ndm_checkconsistency/makefile' do |s|
#      s.gsub! '/usr/bin/pyuic4', "#{HOMEBREW_PREFIX}/bin/pyuic4" 
#      s.gsub! '/usr/bin/pyrcc4', "#{HOMEBREW_PREFIX}/bin/pyrcc4" 
#    end
#
#    inreplace 'python/ndm_prepare/makefile' do |s|
#      s.gsub! '/usr/bin/pyuic4', "#{HOMEBREW_PREFIX}/bin/pyuic4" 
#      s.gsub! '/usr/bin/pyrcc4', "#{HOMEBREW_PREFIX}/bin/pyrcc4" 
#    end

    # Removed 'extractled' since it can not be build for x64
    rm_r 'src/process_extractleds'
    rm 'scripts/ndm_extractleds'
    rm 'descriptions/ndm_extractleds.xml'
    
    # Remove process_merge since it can not be build with clang (VLA)
    rm_r 'src/process_merge'
    rm 'scripts/ndm_mergedat'
    rm 'descriptions/ndm_mergedat.xml'

    # Set install dir correctly. ToDo: Use inreplace instead.
    system "for file in \$(grep -rl 'INSTALL_DIR =' .); do sed -i '' 's;INSTALL_DIR = /usr;INSTALL_DIR = #{prefix};' \$file; done"

    # Make sure xml docbook files can be found, to make sure local version is used.
    ENV['XML_CATALOG_FILES'] = "#{etc}/xml/catalog"

    system "make"
    system "make install"
  end

  def caveats; <<-EOS.undent
      The following plugins are unbuildable and were deactivated: ndm_mergedat and process_merge (clang does not support VLA), ndm_extractleds and process_extractleds (missing x64 support).
    EOS
  end

  test do
    system "false"
  end
end
