class Dnstracer < Formula
  desc "Trace a chain of DNS servers to the source"
  homepage "https://www.mavetju.org/unix/dnstracer.php"
  url "https://www.mavetju.org/download/dnstracer-1.9.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/d/dnstracer/dnstracer_1.9.orig.tar.gz"
  sha256 "2ebc08af9693ba2d9fa0628416f2d8319ca1627e41d64553875d605b352afe9c"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "953752b2c3a012b0e92cd6fc78ef47d7b585e9a3034ef667a9ce3d353c4bb1db"
    sha256 cellar: :any_skip_relocation, mojave:      "8fceeded94f224e8204c253197d742e5d2f94a83684b5ca0613f50841bd0ebe6"
    sha256 cellar: :any_skip_relocation, high_sierra: "29086b127a2967e8e481c60e397fe803165be2d1ad46be7176642567d8844cc0"
    sha256 cellar: :any_skip_relocation, sierra:      "4d89811df14c8564d1ad2dae5a2f45f5e11a51f7b7ecb5f75f692b9507451b7b"
    sha256 cellar: :any_skip_relocation, el_capitan:  "d90b34cfc2d03af3c80ef6118484ddff05863a0e4d9a7a5db8bcf3801bcb3414"
    sha256 cellar: :any_skip_relocation, yosemite:    "13eaef32eb5d1dd11e71adeb6abe9bd43200a219951648d0d4eb707ea935c542"
    sha256 cellar: :any_skip_relocation, mavericks:   "d4b8c5352a711e86091779e6565f752828af549c5806fdf3d58cb572e977aaa4"
  end

  def install
    ENV.append "LDFLAGS", "-lresolv"

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    system "#{bin}/dnstracer", "brew.sh"
  end
end
