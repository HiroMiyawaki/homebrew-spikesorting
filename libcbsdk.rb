class Libcbsdk < Formula
  desc "Library to interact with Blackrock Microsystems neural signal processing hardware"
  homepage "https://neurosuite.github.io"
  url "https://github.com/neurosuite/libcbsdk/archive/v6.4.0.tar.gz"
  version "6.4.0"
  sha256 "7b4d2efd6a502aa4a41ced3e4e23fc3cc7cef73f97d76c0394d93826feeb2e40"

  depends_on "cmake" => :build

  depends_on "qt5" if build.without? "qt4"
  depends_on "qt4" => :optional

  def install
    args = std_cmake_args
    args << "-DWITH_QT4=ON" if build.with? "qt4"

    system "cmake", ".", *args
    system "make", "install"
  end

  test do
    system "test", "-e", "#{lib}/libcbsdk.dylib"
  end
end
