class Rpg < Formula
  desc "Ruby package management for UNIX"
  homepage "https://github.com/rtomayko/rpg"
  url "https://github.com/downloads/rtomayko/rpg/rpg-0.3.0.tar.gz"
  sha256 "c350f64744fb602956a91a57c8920e69058ea42e4e36b0e74368e96954d9d0c7"
  license "MIT"
  head "https://github.com/rtomayko/rpg.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "826bacff2dddeeeb41cdf328b7702fa415d049b9d1d55b2f93e7f1084ebcb3e0"
    sha256 cellar: :any_skip_relocation, mojave:      "995850411f4a47126309c849e2da32c76abaddf40317515d7af5b8d2e2d6d680"
    sha256 cellar: :any_skip_relocation, high_sierra: "27b65a242fd862d805460bc06c91d7f164935dd14f8ded5cfa62924a1b973a42"
    sha256 cellar: :any_skip_relocation, sierra:      "ddb4f887b798101d95300f0b0c22a0760d06158c09796e9bfb65869f28b69434"
    sha256 cellar: :any_skip_relocation, el_capitan:  "be6550c915e361dcc0e020048f9a5f4ea37f1c5890a526282a3d70c610594981"
    sha256 cellar: :any_skip_relocation, yosemite:    "5c1af29955697dcd46ff58fd70f9aca986b977f3cc17f638822c81289f180df2"
    sha256 cellar: :any_skip_relocation, mavericks:   "2ebf1a744c3c072c107883f565c04154b3e530c93868bb438bb90a1be35a4cb7"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/rpg", "config"
  end
end
