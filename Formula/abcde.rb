class Abcde < Formula
  desc "Better CD Encoder"
  homepage "https://abcde.einval.com"
  url "https://abcde.einval.com/download/abcde-2.9.3.tar.gz"
  sha256 "046cd0bba78dd4bbdcbcf82fe625865c60df35a005482de13a6699c5a3b83124"
  license "GPL-2.0"
  head "https://git.einval.com/git/abcde.git"

  bottle do
    sha256 cellar: :any_skip_relocation, mojave:      "6994f8e32417a1630b2680c96bcae3de5c430976de0dc66056e5687070473f19"
    sha256 cellar: :any_skip_relocation, high_sierra: "6994f8e32417a1630b2680c96bcae3de5c430976de0dc66056e5687070473f19"
    sha256 cellar: :any_skip_relocation, sierra:      "7fbfff0c184bef38f29580ec587d5edb473699eaad29bb15e686d2634c070737"
  end

  depends_on "cd-discid"
  depends_on "cdrtools"
  depends_on "flac"
  depends_on "glyr"
  depends_on "id3v2"
  depends_on "lame"
  depends_on "mkcue"
  depends_on "vorbis-tools"

  def install
    system "make", "install", "prefix=#{prefix}", "sysconfdir=#{etc}"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/abcde -v")
  end
end
