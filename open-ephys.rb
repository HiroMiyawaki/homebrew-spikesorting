require 'formula'

class OpenEphys < Formula
  homepage 'http://open-ephys.org/#/gui/'
  url  'https://github.com/open-ephys/GUI/archive/v0.2.tar.gz'
  sha1 '4a43190637b06eee060503be8218388cb06ea9a1'

  head 'https://github.com/open-ephys/GUI.git', :using => :git

  depends_on :xcode => :build
  depends_on 'libftdi'

  def install
    system "xcodebuild install DSTROOT=#{prefix} INSTALL_PATH=/ SYMROOT=build OBJROOT=objroot ARCHS=x86_64 ONLY_ACTIVE_ARCH=NO -project Builds/MacOSX/open-ephys.xcodeproj -target open-ephys -configuration Release"
  end

   def caveats; <<-EOS.undent
      open-ephys is an gui only application.

      To install the Mac OS X wrapper application run:
        brew linkapps [--system]
      
      If the optional '--system' flag is not set, the wrapper 
      is installed into '~/Applications/' instead of '/Applications/'.

      Alternativly you can also run:
        ln -s #{opt_prefix}/open-ephys.app /Applications
    EOS
  end

  test do
    system "open #{prefix}/open-ephys.app"
  end
end
