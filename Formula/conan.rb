class Conan < Formula
  include Language::Python::Virtualenv

  desc "Distributed, open source, package manager for C/C++"
  homepage "https://github.com/conan-io/conan"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://github.com/conan-io/conan/archive/1.18.1.tar.gz"
  sha256 "e5ac365785daded49be1e85606108c1fc551bba34084867e0591090e7277cde9"
=======
  url "https://github.com/conan-io/conan/archive/1.18.2.tar.gz"
  sha256 "5e53bd4e1db4581502b1e327840a458c830d2322b1b9d20630212e061d706390"
>>>>>>> upstream/master
=======
  url "https://github.com/conan-io/conan/archive/1.18.3.tar.gz"
  sha256 "09a229ee0402ed23a30812df47c9b0c3f416eb19bb79994e0ade232fa6260446"
>>>>>>> upstream/master
=======
  url "https://github.com/conan-io/conan/archive/1.19.1.tar.gz"
  sha256 "9904036b946bebb2667b7acc9a648186b975ebe6bc125cc6c04906ec0cfd4eb2"
>>>>>>> upstream/master
  head "https://github.com/conan-io/conan.git"

  bottle do
    cellar :any
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    sha256 "e0aac8eda1dc673cfec75c4a0f27268a30aa7bd870657dfe99dedfc27985c8b1" => :mojave
    sha256 "74abdaac136f95459187a3402f54e1a348ee356e4ad8a61a444da007a397e94a" => :high_sierra
    sha256 "2f76f5ca7eca79b24948a6105732fef444308df207b5044f813d54a1ecb46d6a" => :sierra
=======
    sha256 "5e98423e591025d7399794980e4eac216e546a9159cda9a2c5d304b320b261c9" => :mojave
    sha256 "360e7dfdf7f76d2b9046c0be90e6ab42da26023be2fce2aae2984164bf5324fb" => :high_sierra
    sha256 "d012eeeadaec008f1248daa2596dae45dbc13a057916fe447bb0a7ac3aecad74" => :sierra
>>>>>>> upstream/master
=======
    sha256 "7a33a82decd89d1547b7fb2f137934ba9ed794f7f8f671d772b7acf0adf4db25" => :mojave
    sha256 "61e4302c8c888738519e969bd51a875b3febccd1c241aae974c4b6d2f6ab867b" => :high_sierra
    sha256 "bbeed7494d50aee4a5e40cf34e019e5566be96ed2a18af8f224ff25d2c5f4b67" => :sierra
>>>>>>> upstream/master
=======
    sha256 "51446e38131cfa12fc060aafe4f16358e9e49036d0fbe6b59bbfd835efc84a50" => :catalina
    sha256 "635e41e8f564891268b2b31481ab821034fcaa561e8325ed1357eb0ebace49ac" => :mojave
    sha256 "9dff047a80c4b21ca4ab4f1bda6d6581022baea4cf676f270e81334f33b35afa" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "pkg-config" => :build
  depends_on "libffi"
  depends_on "openssl@1.1"
  depends_on "python"

  def install
    venv = virtualenv_create(libexec, "python3")
    system libexec/"bin/pip", "install", "-v", "--no-binary", ":all:",
                              "--ignore-installed", "PyYAML==3.13", buildpath
    system libexec/"bin/pip", "uninstall", "-y", name
    venv.pip_install_and_link buildpath
  end

  test do
    system bin/"conan", "install", "zlib/1.2.11@conan/stable", "--build"
    assert_predicate testpath/".conan/data/zlib/1.2.11", :exist?
  end
end
