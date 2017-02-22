require 'formula'

class NdmanagerPlugins < Formula
  homepage 'http://ndmanager.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/ndmanager/ndmanager-plugins/ndmanager-plugins-1.4.7/ndmanager-plugins_1.4.7.tar.gz'
  sha256 '7e5b315d34e56a3370dba1c3453eee74052d933bf07cff5aebb83566ef63b758'

  depends_on 'docbook-xsl' => :build
  depends_on "pkg-config" => :build

  depends_on :python
  depends_on 'sdl'
  depends_on 'gsl'
  depends_on 'libsamplerate'
  depends_on 'pyqt5'

#  def patches
    # Fixes bash colors, strdupa and sed syntax differences. Second patch cleans up makefiles
#    { :p0 => [ "https://gist.github.com/FloFra/6353466/raw/70f2c3f52ec63dd9f1e669c6ec394e45c8b089fa/ndmanager-plugins_os-x.patch",
#               "https://gist.github.com/FloFra/6367345/raw/268d9b110d42985df48e3668d80ff326d369aa65/ndmanager-plugins_makefile-cleanup.patch",
#               "https://gist.github.com/FloFra/46a604abccbd703cb463/raw/767d44e1c77cdaac3bac65f7ffbd0145165867de/ndmanager-plugins_removeartefact-main-return-type.patch"] }
#  end
  
  def install

#    # Make sure sdl, gsl are found.
#    inreplace 'src/process_pca/makefile' do |s|
#      s.gsub! '-L/usr/lib'    , "-L#{HOMEBREW_PREFIX}/lib"
#      s.gsub! '-I/usr/include', "-I#{HOMEBREW_PREFIX}/include"
#    end
#
    # Make sure pyqt is found
    inreplace 'python/ndm_checkconsistency/makefile' do |s|
      s.gsub! '/usr/bin/pyuic4', "#{HOMEBREW_PREFIX}/bin/pyuic5" 
      s.gsub! '/usr/bin/pyrcc4', "#{HOMEBREW_PREFIX}/bin/pyrcc5" 
    end

    inreplace 'python/ndm_prepare/makefile' do |s|
      s.gsub! '/usr/bin/pyuic4', "#{HOMEBREW_PREFIX}/bin/pyuic5" 
      s.gsub! '/usr/bin/pyrcc4', "#{HOMEBREW_PREFIX}/bin/pyrcc5" 
    end

    inreplace 'makefile' do |s|
      s.gsub! '@echo "Making all in $(PYTHON_DIR)..."; (cd $(PYTHON_DIR); $(MAKE));', ''
      s.gsub! '@(cd $(PYTHON_DIR)$$i; $(MAKE) clean);', ''
      s.gsub! '@(cd $(PYTHON_DIR); $(MAKE) install);', ''
      s.gsub! '@(cd $(PYTHON_DIR)$$i; $(MAKE) uninstall);', ''
    end

    inreplace 'src/process_resample/makefile' do |s|
      s.gsub! 'all: lib $(EXEC) doc','all: $(EXEC) doc'
      s.gsub! 'LIBS = -L/usr/lib','LIBS = -L/usr/local/lib'
    end
    rm_r 'src/process_resample/libsamplerate-0.1.8'

    # Removed 'extractled' since it can not be build for x64
    rm_r 'src/process_extractleds'
    rm 'scripts/ndm_extractleds'
    rm 'descriptions/ndm_extractleds.xml'
    
    # Remove process_merge since it can not be build with clang (VLA)
    rm_r 'src/process_merge'
    rm 'scripts/ndm_mergedat'
    rm 'descriptions/ndm_mergedat.xml'

    # Set install dir correctly. ToDo: Use inreplace instead.
    system "for file in \$(grep -rl 'INSTALL_DIR =' .); do sed -i '' 's;INSTALL_DIR = /usr;INSTALL_DIR = /usr/local;' \$file; done"

    system "for file in \$(grep -rl 'INSTALLDIR = /usr' .); do sed -i '' 's;INSTALLDIR = /usr;INSTALLDIR = /usr/local;' \$file; done"

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
