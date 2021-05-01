class Clockywock < Formula
  desc "Ncurses analog clock"
  homepage "https://soomka.com/"
  url "https://soomka.com/clockywock-0.3.1a.tar.gz"
  sha256 "278c01e0adf650b21878e593b84b3594b21b296d601ee0f73330126715a4cce4"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "5bc4dcd5f3b6d995d6245d3f67a55fb2b5bb6d604e9ad214bc687f4ca8d40bd8"
    sha256 cellar: :any_skip_relocation, mojave:      "3b3b0faab6694a2572ad18b332b0711d43a7bf73715d0826df0adeacef0c64ed"
    sha256 cellar: :any_skip_relocation, high_sierra: "4d1b976443480421f6b666121b31b350d7881b26832a65f13866a81fda61aa9e"
    sha256 cellar: :any_skip_relocation, sierra:      "d25af48f1f063a64f514a632ffd1c017ba4dd2c0abc2b428489147247eb8cfaf"
    sha256 cellar: :any_skip_relocation, el_capitan:  "12ce1b232f8dfa658e774f8ae08b99f40ca6ae12ee2d5df41af67412412c2b43"
    sha256 cellar: :any_skip_relocation, yosemite:    "fccbf3e83841993156fa544c0b0f30a92058facf07ce5b1e622aec78e2573aff"
    sha256 cellar: :any_skip_relocation, mavericks:   "c4919f759cc8446bc8d83ff71a52de61bd8ba8db11eccfb43270e54c1949227f"
  end

  def install
    system "make"
    bin.install "clockywock"
    man7.install "clockywock.7"
  end

  test do
    system "#{bin}/clockywock", "-h"
  end
end
