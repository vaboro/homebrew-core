class Vcprompt < Formula
  desc "Provide version control info in shell prompts"
  homepage "https://bitbucket.org/gward/vcprompt"
  url "https://bitbucket.org/gward/vcprompt/downloads/vcprompt-1.2.1.tar.gz"
  sha256 "98c2dca278a34c5cdbdf4a5ff01747084141fbf4c50ba88710c5a13c3cf9af09"

  livecheck do
    skip "Bitbucket repository is missing"
  end

  bottle do
    rebuild 1
    sha256 cellar: :any, catalina:    "8ea1dcba5986f35a4bf282a0970be07e4767a4b98669c01989554db4d67f0b4a"
    sha256 cellar: :any, mojave:      "9c1a9204571d68401cca95f2ee1acbf5c1b0cd22f0f9251d506a4a201d795dfc"
    sha256 cellar: :any, high_sierra: "cd5abc9fe361da52bef71b639adc956a8b18f02cbf95272ddf9802862d469090"
    sha256 cellar: :any, sierra:      "9416ab35f637cc751b667f1a8481d17936faa58f39749d87e4e32b07b647f229"
    sha256 cellar: :any, el_capitan:  "11e4de5f008aec3510274ef2265d6d30d214249e127cc1d3045b01b47232c96b"
    sha256 cellar: :any, yosemite:    "a6b02f96a018c993568e4ee43bfa23343c88aa4c6aa58b4727b69c01340f59ff"
    sha256 cellar: :any, mavericks:   "ee133ff8277ce6d7792acd261ba3f27259e677badfe73b80ffd6fd08c6cd3665"
  end

  head do
    url "https://bitbucket.org/gward/vcprompt", using: :hg
    depends_on "autoconf" => :build
  end

  depends_on "sqlite"

  def install
    system "autoconf" if build.head?

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"

    system "make", "PREFIX=#{prefix}",
                   "MANDIR=#{man1}",
                   "install"
  end

  test do
    system "#{bin}/vcprompt"
  end
end
