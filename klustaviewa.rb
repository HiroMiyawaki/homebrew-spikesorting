require 'formula'

class Klustaviewa < Formula
  homepage 'http://klusta-team.github.io/klustaviewa/'
  url 'http://klustaviewa.rossant.net/klustaviewa-0.1.0.dev.zip'
  sha1 '39101243bb0d3630edafd7aea28e98d2d7676d4c'
  head 'https://github.com/rossant/klustaviewa.git'

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

  test do
    system "klustaviewa"
  end
end
