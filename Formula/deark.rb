require "base64"

class Deark < Formula
  desc "File conversion utility for older formats"
  homepage "https://entropymine.com/deark/"
  url "https://entropymine.com/deark/releases/deark-1.5.5.tar.gz"
  sha256 "fea8ae40759d023baf39a89c5fdd157748d8d24591641c9d1b77106a28f1eb56"

  livecheck do
    url "https://entropymine.com/deark/releases/"
    regex(/href=.*?deark[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "f8d53f955cfd1e3e506c9db344479771a29d4a59408a845dcf58fa3c13f21641"
    sha256 cellar: :any_skip_relocation, mojave:      "950b65739f9a3770e1e98ef497aef22a529f31aff07186e287dc41764ca8086f"
    sha256 cellar: :any_skip_relocation, high_sierra: "a66a4003564df921fd305c02fc9a2996093780365841a615615f953946f2b37d"
  end

  def install
    system "make"
    bin.install "deark"
  end

  test do
    (testpath/"test.gz").write ::Base64.decode64 <<~EOS
      H4sICKU51VoAA3Rlc3QudHh0APNIzcnJ11HwyM9NTSpKLVfkAgBuKJNJEQAAAA==
    EOS
    system "#{bin}/deark", "test.gz"
    file = (testpath/"output.000.test.txt").readlines.first
    assert_match "Hello, Homebrew!", file
  end
end
