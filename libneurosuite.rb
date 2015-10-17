class Libneurosuite < Formula
  desc "Support library for Klusters, Neuroscope and NDManager"
  homepage "https://neurosuite.github.io"
  url "https://github.com/neurosuite/libneurosuite/archive/v2.0.0.tar.gz"
  sha256 "4a902fcbe027a03c792e01ce6465f46c65340514ec578ca5dcd71e240aac195b"
  head "https://github.com/neurosuite/libneurosuite.git"

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
