class Pv < Formula
  desc "Monitor data's progress through a pipe"
  homepage "https://www.ivarch.com/programs/pv.shtml"
  url "https://www.ivarch.com/programs/sources/pv-1.6.6.tar.bz2"
  sha256 "608ef935f7a377e1439c181c4fc188d247da10d51a19ef79bcdee5043b0973f1"

  livecheck do
    url :homepage
    regex(/href=.*?pv[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "a5a43d38f36d54dd3e01d70ab6faa68af3ddc7cb80302f02945d1344eee7b7d4"
    sha256 cellar: :any_skip_relocation, mojave:      "790e86acba53eecbff8e20753df00ef139dbc686d0dac27062d57c0a47eaac76"
    sha256 cellar: :any_skip_relocation, high_sierra: "4beeaa40f09a609c2706a945ec04b2b6a156efc0befe9dc571ec426f3a152cba"
    sha256 cellar: :any_skip_relocation, sierra:      "231a659ee3aca5a6f474bc058ed02a0a5f2c366d04c8c56043d310644c46e393"
    sha256 cellar: :any_skip_relocation, el_capitan:  "d461d873a47091a52b6114ac0976f16b0ade9e13d02fa0609f574369b8cfc8f0"
    sha256 cellar: :any_skip_relocation, yosemite:    "0c4d4a90c188370ed312490b7ff76fdb8a31399170cdc0ad5dfc1542af4c4fc0"
  end

  def install
    system "./configure", "--disable-debug", "--prefix=#{prefix}",
                          "--mandir=#{man}", "--disable-nls"
    system "make", "install"
  end

  test do
    progress = pipe_output("#{bin}/pv -ns 4 2>&1 >/dev/null", "beer")
    assert_equal "100", progress.strip
  end
end
