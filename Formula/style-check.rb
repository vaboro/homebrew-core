class StyleCheck < Formula
  desc "Parses latex-formatted text in search of forbidden phrases"
  homepage "https://www.cs.umd.edu/~nspring/software/style-check-readme.html"
  url "https://www.cs.umd.edu/~nspring/software/style-check-0.14.tar.gz"
  sha256 "2ae806fcce9e3b80162c64634422dc32d7f0e6f8a81ba5bc7879358744b4e119"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "5f652a7db0691978cb42a5be5d0e293e671c2953364b64b75a0ba663b581051c"
    sha256 cellar: :any_skip_relocation, mojave:      "6427d438896bf32d45e0f71aa3d81817e59ac39ffc23cc6fc0ef1a29fb413491"
    sha256 cellar: :any_skip_relocation, high_sierra: "3fdd513cff0a9f298357e5e918532bc2c236cbb6bf4c981a77270c69b49b9f08"
    sha256 cellar: :any_skip_relocation, sierra:      "1a6787ed0c5cbe6ee567e112b16d5d32193bb0dacbf23e515f512df3287a3abd"
    sha256 cellar: :any_skip_relocation, el_capitan:  "8ad833cef9ca35a1ae95569f93c8936a82c6d6039e3bd4560e2b1dc93fd029d8"
    sha256 cellar: :any_skip_relocation, yosemite:    "08759f3a407af4dab0310f4a02ee18f15f2104011d702a300adbe9d33bcde0f5"
    sha256 cellar: :any_skip_relocation, mavericks:   "afeff378c5e3aac20d3fa3756d7dbd85242f6d4d846e9cd670f3119069e83a52"
  end

  def install
    inreplace "style-check.rb", "/etc/style-check.d/", etc/"style-check.d/"
    system "make", "PREFIX=#{prefix}",
                   "SYSCONFDIR=#{etc}/style-check.d",
                   "install"
  end

  test do
    (testpath/".style-censor").write "homebrew % capitalize Homebrew\n"
    (testpath/"paper.tex").write "Today I worked on homebrew\n"

    system "#{bin}/style-check.rb", "-v", "paper.tex"
  end
end
