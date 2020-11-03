class Yafc < Formula
  desc "Command-line FTP client"
  homepage "https://github.com/sebastinas/yafc"
  url "https://deb.debian.org/debian/pool/main/y/yafc/yafc_1.3.7.orig.tar.xz"
  sha256 "4b3ebf62423f21bdaa2449b66d15e8d0bb04215472cb63a31d473c3c3912c1e0"
  revision 4

  bottle do
    cellar :any
    sha256 "07a19edcc11987e0de79538413a41b683c86de41d216eb2c120f747a3564bfd4" => :catalina
    sha256 "f01687e9e00211d729d0d6bb191d6286b41693c52ecf2e6c5a26874c27589daa" => :mojave
    sha256 "d2344380f7cee870732888ac9675303edd374400d5c1bbde02f822d09e93d186" => :high_sierra
  end

  depends_on "pkg-config" => :build
  depends_on "libssh"
  depends_on "readline"

  def install
    args = %W[
      --prefix=#{prefix}
      --with-readline=#{Formula["readline"].opt_prefix}
    ]

    system "./configure", *args
    system "make", "install"
  end

  test do
    download_file = testpath/"gcc-10.2.0.tar.xz.sig"
    expected_checksum = Checksum.new("sha256", "8e271266e0e3312bb1c384c48b01374e9c97305df781599760944e0a093fad38")
    output = pipe_output("#{bin}/yafc -W #{testpath} -a ftp://ftp.gnu.org/gnu/gcc/gcc-10.2.0/",
                         "get #{download_file.basename}", 0)
    assert_match version.to_s, output
    download_file.verify_checksum expected_checksum
  end
end
