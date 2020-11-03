class Xonsh < Formula
  include Language::Python::Virtualenv

  desc "Python-ish, BASHwards-compatible shell language and command prompt"
  homepage "https://xon.sh/"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://github.com/xonsh/xonsh/archive/0.9.10.tar.gz"
  sha256 "cecbb35ef16c2159dfbb772c9cfeb0b786d875702566a2c698087a0baf9069ca"
=======
  url "https://github.com/xonsh/xonsh/archive/0.9.11.tar.gz"
  sha256 "8dec5e90c17983afeb2fa7f584795981274104c6eea3c97f7cf66b56d4204f7c"
>>>>>>> upstream/master
=======
  url "https://github.com/xonsh/xonsh/archive/0.9.12.tar.gz"
  sha256 "e7cf4e98ebfb9a35b197e681e426f58e8c0c4ce5aee5e1ec9d1d25a37eb92eda"
>>>>>>> upstream/master
=======
  url "https://github.com/xonsh/xonsh/archive/0.9.21.tar.gz"
  sha256 "b6f6a0fc8b388480bbf7aa1900dc97edf63d100a7dd572be8e5031b754e1c9f5"
  license "BSD-2-Clause-Views"
>>>>>>> upstream/master
  head "https://github.com/xonsh/xonsh.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    sha256 "55f871d9a5511f5effdeb0310203a6c574e85a8e1396888cc0d32c7de7e114b8" => :mojave
    sha256 "5f3629a4f9d967948774e4d3071ee7a057bfa7e1ce77f50da082ad4adc44479f" => :high_sierra
    sha256 "db99e7270ad80c925c2015709b7cbe896936c46b26e86ca09a523b3ddeb1ea1f" => :sierra
=======
    sha256 "c279b4e997cc250643eb7c329be125a5723c7036177b23b52c69c2be6b295e27" => :mojave
    sha256 "700cca4cde3ade58a21a868423cfeca402dcd1fe0370d2fac33bf4ab78da78bb" => :high_sierra
    sha256 "9aaf96327d494c27442df40027520e76acfb09cc6e2f6730d498b54a96b8d867" => :sierra
>>>>>>> upstream/master
=======
    sha256 "007264077bd1dbfdce54e0bd00aec6c8741436f30eed4e73785e8ddeb1d4cb83" => :catalina
    sha256 "5dbdb72ea045465bc12b25d27531f2dbf45639626004449fcb614a1c23ee4678" => :mojave
    sha256 "6df4093828cacb8e7898a06c593e4259764fc6fa86eba5bb6bcbe903d3e11f1f" => :high_sierra
>>>>>>> upstream/master
=======
    sha256 "3e884ff7820dd096c93640599d0d77ea43445d5b4da76601cf87ccbd1ac1c49d" => :catalina
    sha256 "1a30ad503ef95cd9ad2bd6c4eb2e6107b3d862d6702ddc89f0894f5f027d5b37" => :mojave
    sha256 "d8f3d21965fcea70899c89399c6831de20e404f2fa89b4ff03d9a3b3caa6c139" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "python@3.8"

  # Resources based on `pip3 install xonsh[ptk,pygments,proctitle]`
  # See https://xon.sh/osx.html#dependencies

  resource "prompt_toolkit" do
    url "https://files.pythonhosted.org/packages/c4/c6/03da4efaf73f0cb5a34957fdac12046eb8d8e81618bad6f60464215b829a/prompt_toolkit-3.0.6.tar.gz"
    sha256 "7630ab85a23302839a0f26b31cc24f518e6155dea1ed395ea61b42c45941b6a6"
  end

  resource "Pygments" do
    url "https://files.pythonhosted.org/packages/6e/4d/4d2fe93a35dfba417311a4ff627489a947b01dc0cc377a3673c00cf7e4b2/Pygments-2.6.1.tar.gz"
    sha256 "647344a061c249a3b74e230c739f434d7ea4d8b1d5f3721bc0f3558049b38f44"
  end

  resource "setproctitle" do
    url "https://files.pythonhosted.org/packages/5a/0d/dc0d2234aacba6cf1a729964383e3452c52096dc695581248b548786f2b3/setproctitle-1.1.10.tar.gz"
    sha256 "6283b7a58477dd8478fbb9e76defb37968ee4ba47b05ec1c053cb39638bd7398"
  end

  resource "wcwidth" do
    url "https://files.pythonhosted.org/packages/89/38/459b727c381504f361832b9e5ace19966de1a235d73cdbdea91c771a1155/wcwidth-0.2.5.tar.gz"
    sha256 "c4d647b99872929fdb7bdcaa4fbe7f01413ed3d98077df798530e5b04f116c83"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "4", shell_output("#{bin}/xonsh -c 2+2")
  end
end
