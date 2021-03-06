class Fpp < Formula
  desc "CLI program that accepts piped input and presents files for selection"
  homepage "https://facebook.github.io/PathPicker/"
<<<<<<< HEAD
  url "https://github.com/facebook/PathPicker/releases/download/0.8.2/fpp.0.8.2.tar.gz"
  sha256 "dea4fcd470c24c4a5a804307c86948da2a8d5fa5faaefe5892418f4ddae89c75"
=======
  url "https://github.com/facebook/PathPicker/releases/download/0.9.2/fpp.0.9.2.tar.gz"
  sha256 "f2b233b1e18bdafb1cd1728305e926aabe217406e65091f1e58589e6157e1952"
<<<<<<< HEAD
>>>>>>> upstream/master
=======
  license "MIT"
  revision 1
>>>>>>> upstream/master
  head "https://github.com/facebook/pathpicker.git"

  bottle :unneeded

  depends_on "python@3.8"

  def install
    # we need to copy the bash file and source python files
    libexec.install Dir["*"]
    # and then symlink the bash file
    bin.install_symlink libexec/"fpp"
  end

  test do
    system bin/"fpp", "--help"
  end
end
