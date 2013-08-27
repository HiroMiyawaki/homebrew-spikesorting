require 'formula'

class OpenEphys < Formula
  homepage 'http://open-ephys.org/#/gui/'
  head 'https://github.com/open-ephys/GUI.git', :using => :git
  url  'https://github.com/open-ephys/GUI/archive/v0.1.tar.gz'
  sha1 '903d19349ee09e7cbaf4ea389ee4f8845a7c3aca'

  depends_on :xcode => :build
  depends_on 'libftdi'

  def install
    system "xcodebuild install DSTROOT=#{prefix} SYMROOT=build OBJROOT=objroot -project Builds/MacOSX/open-ephys.xcodeproj -target open-ephys -configuration Release"
  end

  test do
    system "open open-ephys"
  end
end
