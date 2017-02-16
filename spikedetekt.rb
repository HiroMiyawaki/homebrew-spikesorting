require 'formula'

class Spikedetekt < Formula
  homepage 'http://klusta-team.github.io/spikedetekt/'
  url 'http://downloads.sourceforge.net/project/spikedetekt/SpikeDetekt0.1.2.tar.gz'
  sha256 '682afe5a55f3cf89de805a2b2552ac8ad054ed28643e00301a0809bc219edf67'
  head 'https://github.com/klusta-team/spikedetekt.git'

  depends_on :python
  depends_on 'numpy' => :python
  depends_on 'scipy' => :python
  depends_on 'hdf5' => :python
  depends_on 'tables' => :python

  def install
    system python, "setup.py", "install", "--prefix=#{prefix}", "--single-version-externally-managed", "--record=installed.txt"
  end

  def caveats; <<-EOS.undent
        This formula is OUTDATED.

        If you want a newer version, please uninstall this homebrew 
        package and run (--upgrade might be needed in certain cases):
          pip install spikedetekt [--upgrade]
    EOS
  end

  test do
    system "detektSpikes.py"
  end
end
