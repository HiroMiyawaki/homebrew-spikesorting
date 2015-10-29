class Neuroscope < Formula
  desc "An advanced viewer for electrophysiological and behavioral data"
  homepage "https://neurosuite.github.io"
  url "https://github.com/neurosuite/neuroscope/archive/v2.1.0.tar.gz"
  sha256 "da39ef4611d3400ac2e6a479a5a862d3f26c6347034a1de67e68911e1b9ee28a"

  head "https://github.com/neurosuite/neuroscope.git", :branch => "blackrock"

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
