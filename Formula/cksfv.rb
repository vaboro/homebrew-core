class Cksfv < Formula
  desc "File verification utility"
  homepage "https://zakalwe.fi/~shd/foss/cksfv/"
  url "https://zakalwe.fi/~shd/foss/cksfv/files/cksfv-1.3.14.tar.bz2"
  sha256 "8f3c246f3a4a1f0136842a2108568297e66e92f5996e0945d186c27bca07df52"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "ee0e6d47bba7ece1e9d3f89db630ba943d2e85834d1b2c7c4307e449f8de517f"
    sha256 cellar: :any_skip_relocation, mojave:      "fcefe9fe38fb4555760f8d7e651f19aca85115583f896ba602b1396e71547743"
    sha256 cellar: :any_skip_relocation, high_sierra: "095a3a02e99d3f018472202e65231212c818750cd91d42c32a95957b407c1d4b"
    sha256 cellar: :any_skip_relocation, sierra:      "4414da8e35f9d69a0e04e4a1942745f98b5234891a04935627248e2e6954e17d"
    sha256 cellar: :any_skip_relocation, el_capitan:  "41d81d535cfa41b4eb03709e646b0bdc36a78f99c8e15746b7eb289a98afbb97"
    sha256 cellar: :any_skip_relocation, yosemite:    "9885cadccdeec56d0f665bad80655cfba3397c3ff2958c7a44af514a69bc8114"
    sha256 cellar: :any_skip_relocation, mavericks:   "3838548d5febbed5d9db37e8634397a589bcec766ee5ec84949a17dae9b34cdd"
  end

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    path = testpath/"foo"
    path.write "abcd"

    assert_match "#{path} ED82CD11", shell_output("#{bin}/cksfv #{path}")
  end
end
