class Libcbsdk < Formula
  desc "Library to interact with Blackrock Microsystems NSP hardware"
  homepage "https://neurosuite.github.io"
  url "https://github.com/neurosuite/libcbsdk/archive/v6.4.1.tar.gz"
  sha256 "a1e1fa5c67e59c53f4ee7a57e241e124486e5e96c8e04a1ca73c2c7bdab4ee9e"
  head "https://github.com/neurosuite/libcbsdk.git"

  depends_on "cmake" => :build

  depends_on "qt5"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
