class Libneurosuite < Formula
  desc "Library for shared functionality between Klusters, Neuroscope and NDManager"
  homepage "https://neurosuite.github.io"
  url "https://github.com/neurosuite/libneurosuite/archive/v2.0.0.tar.gz"
  version "2.0.0"
  sha256 "28fce747b8213dc822effefb764060b08dd9d1a7f8f20ae6344a661f6bd0d569"

  depends_on "cmake" => :build

  depends_on "qt5" if build.without? "qt4"
  depends_on "qt4" => :optional

  def install
    args = std_cmake_args
    args << "-DWITH_QT4=ON" if build.with? "qt4"

    system "cmake", ".", *args
    system "make", "install"
  end
end
