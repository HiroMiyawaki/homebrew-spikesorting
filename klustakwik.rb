require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Klustakwik < Formula
  homepage 'http://klustakwik.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/klustakwik/klustakwik/KlustaKwik-2.0.1.tar.bz2'
  sha256 'a5ccaba9fd9383591023d03bcedf339de462f9dbd540b424c873b6648172cf7a' 

  def install
    system "make"
    bin.install "KlustaKwik" => "klustakwik"
  end

  test do
    system "klustakwik"
  end
end
