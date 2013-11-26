require 'formula'

class Klustaviewa < Formula
  homepage 'http://klusta-team.github.io/klustaviewa/'
  url 'http://klustaviewa.rossant.net/klustaviewa-0.1.0.dev.zip'
  sha1 'ddccd0b46757e38ba1518910028cbe9436db1561'
  head 'https://github.com/klusta-team/klustaviewa.git'

  depends_on 'qt'
  depends_on 'pyqt'
  depends_on :python
  depends_on 'numpy' => :python
  depends_on 'pandas' => :python
  depends_on 'matplotlib' => :python
  depends_on LanguageModuleDependency.new :python, 'pyopengl', 'OpenGL'

  def install
    system "mkdir -p #{prefix}/lib/python2.7/site-packages"
    system python, "setup.py", "install", "--prefix=#{prefix}", "--single-version-externally-managed", "--record=installed.txt"
  end

def caveats; <<-EOS.undent
        This formula is OUTDATED.

        If you want a newer version, please uninstall this homebrew 
        package and run (--upgrade might be needed in certain cases):
          pip install klustaviewa [--upgrade]
    EOS
  end

  test do
    system "klustaviewa"
  end
end
