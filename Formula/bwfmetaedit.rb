class Bwfmetaedit < Formula
  desc "Tool for embedding, validating, and exporting BWF file metadata"
  homepage "https://mediaarea.net/BWFMetaEdit"
  url "https://mediaarea.net/download/binary/bwfmetaedit/20.08/BWFMetaEdit_CLI_20.08_GNU_FromSource.tar.bz2"
  sha256 "273600425521d27aa3babd5d564e7c7a8c71bbf359e0bdebeac4761fc753149b"
  license "0BSD"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "f8fc7ea2c57a3eaa0a247cbce5ae47839efc7ef098f3333d34f0d5628250fef2"
    sha256 cellar: :any_skip_relocation, mojave:      "8c0514552045937ff4ed9d27073ffcd9e4516b44fea073eddd11729ac8fe2c7e"
    sha256 cellar: :any_skip_relocation, high_sierra: "bc8b768a4849b8c3740b18becc861fac1cde2e5294662dcd6e5c5697b91b15a2"
  end

  def install
    cd "Project/GNU/CLI" do
      system "./configure",  "--disable-debug", "--prefix=#{prefix}"
      system "make", "install"
    end
  end

  test do
    pipe_output("#{bin}/bwfmetaedit --out-tech", test_fixtures("test.wav"))
  end
end
