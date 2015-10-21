class Libneurosuite < Formula
  desc "Support library for Klusters, Neuroscope and NDManager"
  homepage "https://neurosuite.github.io"
  url "https://github.com/neurosuite/libneurosuite/archive/v2.0.0.tar.gz"
  sha256 "215e05b1e0c7803b0f0244894c348cc6ce06298079e8ceacbeff7b6f1540ec3a"
  head "https://github.com/neurosuite/libneurosuite.git"

  depends_on "cmake" => :build

  depends_on "qt5"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
