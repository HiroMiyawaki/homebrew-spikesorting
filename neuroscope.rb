class Neuroscope < Formula
  desc "An advanced viewer for electrophysiological and behavioral data"
  homepage "https://neurosuite.github.io"
  url "https://github.com/neurosuite/neuroscope/archive/v2.1.0.tar.gz"
  sha256 "68c45bc1a96354b936f69d9b3f72a5260e06c6856bd5a6f52a27cc22c46f16e0"
  head "https://github.com/neurosuite/neuroscope.git"

  depends_on "cmake" => :build

  depends_on "qt5"
  depends_on "libneurosuite"

  depends_on "libcbsdk" => :optional

  def install
    args = std_cmake_args
    args << "-DWITH_CEREBUS=ON" if build.with? "libcbsdk"

    system "cmake", ".", *args
    system "make", "install"
  end
end
