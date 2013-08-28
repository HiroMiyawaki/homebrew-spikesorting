require 'formula'

class OpenEphys < Formula
  homepage 'http://open-ephys.org/#/gui/'
  url  'https://github.com/open-ephys/GUI/archive/v0.1.tar.gz'
  sha1 '903d19349ee09e7cbaf4ea389ee4f8845a7c3aca'

  head 'https://github.com/open-ephys/GUI.git', :using => :git

  depends_on :xcode => :build
  depends_on 'libftdi'

  def install
    system "xcodebuild install DSTROOT=#{prefix} INSTALL_PATH=/ SYMROOT=build OBJROOT=objroot -project Builds/MacOSX/open-ephys.xcodeproj -target open-ephys -configuration Release"
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
