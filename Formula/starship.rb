class Starship < Formula
  desc "The cross-shell prompt for astronauts"
<<<<<<< HEAD
  homepage "https://github.com/starship/starship"
  url "https://github.com/starship/starship/archive/v0.6.0.tar.gz"
  sha256 "eec9a9f6d694bd14f1aa1e5f4a0a88c12bc4209fe52ec8f12d9dbadbef9ea32a"
=======
  homepage "https://starship.rs"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://github.com/starship/starship/archive/v0.13.1.tar.gz"
  sha256 "990b0e418224900824179bc6c8fca89566696be79d68b8af191da107b7414f46"
  revision 1
>>>>>>> upstream/master
=======
  url "https://github.com/starship/starship/archive/v0.14.1.tar.gz"
  sha256 "2847dcfb604ae1ba49b99310cc0d2a279e8f3f57d17806c219df9fb8c6196c49"
>>>>>>> upstream/master
=======
  url "https://github.com/starship/starship/archive/v0.16.0.tar.gz"
  sha256 "eadf8fc68134ed3c23b558ea0b6701054149ae23d9149613dfc8bed28cc7173d"
>>>>>>> upstream/master
  head "https://github.com/starship/starship.git"

  bottle do
    cellar :any
<<<<<<< HEAD
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
=======
    sha256 "998ace27edf7926741168c3f7bb35503709a7a4046cccbaec1a283bbe31ac611" => :mojave
    sha256 "829e17ff01ba74a13d05ee137d9b9594105ead917f0057d57d2f6195b9e0f435" => :high_sierra
    sha256 "bb6a290c10cadf29972414bdf440fc3d2cd5256a9f0ccc0cd66c19d7a08c6940" => :sierra
>>>>>>> upstream/master
  end

  depends_on "rust" => :build
  depends_on "openssl@1.1"
>>>>>>> upstream/master
=======
  url "https://github.com/starship/starship/archive/v0.21.0.tar.gz"
  sha256 "01c6141d1fb922ddbe595a2141c267059a1b46acf1a22fdb77caa96c53930f40"
=======
  url "https://github.com/starship/starship/archive/v0.44.0.tar.gz"
  sha256 "b002fa0e2b34ad59330a543461a51648751db4ae8d439d58065a3b9656772fe3"
  license "ISC"
  revision 1
>>>>>>> upstream/master
  head "https://github.com/starship/starship.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "a2d50878f224a8af2e0ab1e990d90166f7b4a02a82ebedc9acaa0a0443e04e4a" => :catalina
    sha256 "ff2ec8fa902206c5514b384db12bc36558987d55b335aeb3fddeafae416b5168" => :mojave
    sha256 "7955bc1b29268a4975f23d1312216cf71f50a9e05a82360cfb12a199831496d9" => :high_sierra
  end

  depends_on "rust" => :build
>>>>>>> upstream/master

  uses_from_macos "zlib"

  def install
    system "cargo", "install", *std_cargo_args

    bash_output = Utils.safe_popen_read("#{bin}/starship", "completions", "bash")
    (bash_completion/"starship").write bash_output

    zsh_output = Utils.safe_popen_read("#{bin}/starship", "completions", "zsh")
    (zsh_completion/"_starship").write zsh_output

    fish_output = Utils.safe_popen_read("#{bin}/starship", "completions", "fish")
    (fish_completion/"starship.fish").write fish_output
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
