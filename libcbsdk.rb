class Libcbsdk < Formula
  desc "Library to interact with Blackrock Microsystems neural signal processing hardware"
  homepage "https://neurosuite.github.io"
  url "https://github.com/neurosuite/libcbsdk/archive/v6.4.1.tar.gz"
  sha256 "46222dd1d930f23e5c7f7e14835b0bee4edc296501fe9ba86c43fe70169db4b5"
  head "https://github.com/neurosuite/libcbsdk.git"

  depends_on "cmake" => :build

  depends_on "qt4" => :optional
  depends_on "qt5" if build.without? "qt4"

  def install
    args = std_cmake_args
    args << "-DWITH_QT4=ON" if build.with? "qt4"

    system "cmake", ".", *args
    system "make", "install"
  end
end
