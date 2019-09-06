class Starship < Formula
  desc "The cross-shell prompt for astronauts"
<<<<<<< HEAD
  homepage "https://github.com/starship/starship"
  url "https://github.com/starship/starship/archive/v0.6.0.tar.gz"
  sha256 "eec9a9f6d694bd14f1aa1e5f4a0a88c12bc4209fe52ec8f12d9dbadbef9ea32a"
=======
  homepage "https://starship.rs"
<<<<<<< HEAD
  url "https://github.com/starship/starship/archive/v0.13.1.tar.gz"
  sha256 "990b0e418224900824179bc6c8fca89566696be79d68b8af191da107b7414f46"
  revision 1
>>>>>>> upstream/master
=======
  url "https://github.com/starship/starship/archive/v0.14.1.tar.gz"
  sha256 "2847dcfb604ae1ba49b99310cc0d2a279e8f3f57d17806c219df9fb8c6196c49"
>>>>>>> upstream/master
  head "https://github.com/starship/starship.git"

  bottle do
    cellar :any
<<<<<<< HEAD
<<<<<<< HEAD
    sha256 "0837814004ed18507f45b4282525001c4c5e407f216f778015718a4c385a778f" => :mojave
    sha256 "013016bbacc455e2f2fde8f39e26c17786397518d35c0e01be42d749361b8a42" => :high_sierra
    sha256 "3f0f8a178891b93f61821d7c19f1bdf69e9ae8896f4625621ba6ad298b63598e" => :sierra
  end

  depends_on "rust" => :build
  depends_on "openssl"
=======
    sha256 "64189794918b70f8cc6e0bb470bebffc0cea392119cefe56c886fb8e531821de" => :mojave
    sha256 "5c7740f235568ecfc523addd989957cf62885aa6d460b2a44d71b87804ac4999" => :high_sierra
    sha256 "a98e4d2697dbabddc12b18f514215d33e1518cf3d470ef1f2b247009919cc4d3" => :sierra
=======
    sha256 "99f3937318d4268fbb1d86bd1cb038d3ea2b306b6b34b9802a589499623c3339" => :mojave
    sha256 "0a6d97fe2680cdc67c378d5fd7829cd639d14dbefdeb885a992bd09c256bde53" => :high_sierra
    sha256 "be95c55fc90b20806b4f534c0bffa2d08fb7693b8cfc8b8f2c726b5b4ebb8b39" => :sierra
>>>>>>> upstream/master
  end

  depends_on "rust" => :build
  depends_on "openssl@1.1"
>>>>>>> upstream/master

  def install
    system "cargo", "install", "--root", prefix, "--path", "."
  end

  test do
    ENV["STARSHIP_CONFIG"] = ""
<<<<<<< HEAD
    assert_equal "[1;32m➜[0m ", shell_output("#{bin}/starship module char")
=======
    assert_equal "[1;32m❯[0m ", shell_output("#{bin}/starship module character")
>>>>>>> upstream/master
  end
end
