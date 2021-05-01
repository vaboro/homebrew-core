class Peg < Formula
  desc "Program to perform pattern matching on text"
  homepage "https://www.piumarta.com/software/peg/"
  url "https://www.piumarta.com/software/peg/peg-0.1.18.tar.gz"
  mirror "https://deb.debian.org/debian/pool/main/p/peg/peg_0.1.18.orig.tar.gz"
  sha256 "20193bdd673fc7487a38937e297fff08aa73751b633a086ac28c3b34890f9084"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "bb6bfe4999b4675d3e3d16a52552fe571430fa5956fdff245837f922d7e39842"
    sha256 cellar: :any_skip_relocation, mojave:      "335fda7dd0c4cbd0a2c929daf19693729b3e1592f1880f5a1cb2ebd5ae587c3c"
    sha256 cellar: :any_skip_relocation, high_sierra: "622cd7695294bcac63049e45e934ea1936dfc0f9373046dd028f63a3fe6fa2a4"
    sha256 cellar: :any_skip_relocation, sierra:      "15dfb147f388a8a486714d17d519a1ad1195f79bad5843d37726e8efaab1ae79"
    sha256 cellar: :any_skip_relocation, el_capitan:  "44d0ab83d1bc3ee71294d328dc70dd14206b8d8ddf05a195f2cdf354d746d5dc"
    sha256 cellar: :any_skip_relocation, yosemite:    "9abe69e43c8e2672aa7b5b26df5c80976c2d0365b5d85d672e8948cebe88646f"
    sha256 cellar: :any_skip_relocation, mavericks:   "bbe71ecc8acb17bdf2538f41ae56472bc104a69e310cfd533565507c3468c53c"
  end

  def install
    system "make", "all"
    bin.install %w[peg leg]
    man1.install gzip("src/peg.1")
  end

  test do
    (testpath/"username.peg").write <<~EOS
      start <- "username"
    EOS

    system "#{bin}/peg", "-o", "username.c", "username.peg"

    assert_match(/yymatchString\(yy, "username"\)/, File.read("username.c"))
  end
end
