require 'formula'

# Documentation: https://github.com/mxcl/homebrew/wiki/Formula-Cookbook
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Maskedklustakwik < Formula
  homepage 'http://klustakwik.sourceforge.net/'
  url 'http://downloads.sourceforge.net/project/klustakwik/maskedKlustaKwik/KlustaKwik-3.0.2.bz2'
  sha256 'acdd9a71675d2c0b64809d7f67118eebdb42df1eddfc170b9a00fc8a37dac5b6'

  def install
    system "make"
    bin.install "KlustaKwik" => "maskedklustakwik"
  end

  def caveats; <<-EOS.undent
      Renamed Klustakwik to maskedklustakwik to avoid name conflicts with non-masked klustakwik (version 2.x).
    EOS
  end

  test do
    system "maskedklustakwik"
  end
end
