require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Klustakwik < Formula
  homepage 'http://klustakwik.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/klustakwik/klustakwik/KlustaKwik-2.0.1.tar.bz2'
  sha1 '01b58b7560d947691b4772abb90c940d27ffe4d7'

  def install
    system "make"
    bin.install "KlustaKwik" => "klustakwik"
  end

  test do
    system "klustakwik"
  end
end
