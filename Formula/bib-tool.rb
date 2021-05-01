class BibTool < Formula
  desc "Manipulates BibTeX databases"
  homepage "http://www.gerd-neugebauer.de/software/TeX/BibTool/en/"
  url "https://github.com/ge-ne/bibtool/releases/download/BibTool_2_68/BibTool-2.68.tar.gz"
  sha256 "e1964d199b0726f431f9a1dc4ff7257bb3dba879b9fa221803e0aa7840dee0e0"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "26f2121d720fa6ffc20547b0bfc6754930f6b8660b51f634c686279dae7e73ce"
    sha256 cellar: :any_skip_relocation, mojave:      "d75a1a60204b002cc06acc025cfdc74db76a563b9bb508876d0e45d771f61dc8"
    sha256 cellar: :any_skip_relocation, high_sierra: "0d92e3fead68380fc84cbf5517d2ed2eecdfcbfc1fc14c6343f51ee60d43f948"
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--without-kpathsea"
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.bib").write <<~EOS
      @article{Homebrew,
          title   = {Something},
          author  = {Someone},
          journal = {Something},
          volume  = {1},
          number  = {2},
          pages   = {3--4}
      }
    EOS
    system "#{bin}/bibtool", "test.bib"
  end
end
