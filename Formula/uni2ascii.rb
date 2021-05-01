class Uni2ascii < Formula
  desc "Bi-directional conversion between UTF-8 and various ASCII flavors"
  # homepage/url: "the website you are looking for is suspended"
  # Switched to Debian mirrors June 2015.
  homepage "https://billposer.org/Software/uni2ascii.html"
  url "https://deb.debian.org/debian/pool/main/u/uni2ascii/uni2ascii_4.18.orig.tar.gz"
  sha256 "9e24bb6eb2ced0a2945e2dabed5e20c419229a8bf9281c3127fa5993bfa5930e"
  license "GPL-3.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "58d99cd9438e838d70d1fe8299f44ddaaf6f9378cb5849c0d8e89a178a32fafe"
    sha256 cellar: :any_skip_relocation, mojave:      "97c679d5f838e03832a99e83068eddcddfa5276971f8edcd19b53a33d0179305"
    sha256 cellar: :any_skip_relocation, high_sierra: "e95934b7cfcfc96467f1d9d36ec91e04e53fa0edd71f9c0b8aff6e357128de5a"
    sha256 cellar: :any_skip_relocation, sierra:      "298ca15b89643dfa4946d485105fed7baa6934556c63d2bf97a3b7af0984c325"
    sha256 cellar: :any_skip_relocation, el_capitan:  "3cc5e96fa9c49edb0b06d60af238f4a4803feefe22bbf5924698649e8c4db5fb"
    sha256 cellar: :any_skip_relocation, yosemite:    "0200efd85e37c8c6e2582f82ff8fbb050bba07d31a1bf3720837f5d30da6a54b"
    sha256 cellar: :any_skip_relocation, mavericks:   "b58b9d744048c9e2cc81e75d46c94926d14b2c25a613a05cd0835882221ade7c"
  end

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    ENV["MKDIRPROG"]="mkdir -p"
    system "make", "install"
  end

  test do
    # uni2ascii
    assert_equal "0x00E9", pipe_output("#{bin}/uni2ascii -q", "é")

    # ascii2uni
    assert_equal "e\n", pipe_output("#{bin}/ascii2uni -q", "0x65")
  end
end
