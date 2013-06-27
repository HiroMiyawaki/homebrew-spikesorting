require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Maskedklustakwik < Formula
  homepage 'http://klustakwik.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/klustakwik/maskedKlustaKwik/KlustaKwik-3.0.2.bz2'
  sha1 '4e5bfabbb65b8f6b72b5c3e87374abb2180a28c6'


  def install
    system "make"
    bin.install "KlustaKwik" => "maskedklustakwik"
  end

  test do
    system "maskedklustakwik"
  end
end
