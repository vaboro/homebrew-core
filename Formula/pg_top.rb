class PgTop < Formula
  desc "Monitor PostgreSQL processes"
  homepage "https://pg_top.gitlab.io"
  url "https://ftp.postgresql.org/pub/projects/pgFoundry/ptop/pg_top/3.7.0/pg_top-3.7.0.tar.bz2"
  mirror "https://mirrorservice.org/sites/ftp.postgresql.org/projects/pgFoundry/ptop/pg_top/3.7.0/pg_top-3.7.0.tar.bz2"
  sha256 "c48d726e8cd778712e712373a428086d95e2b29932e545ff2a948d043de5a6a2"
  revision 3

  # We're currently checking the pg_top GitLab repository, since there are new
  # 4.0.0 prerelease versions there that aren't at the existing stable source
  # (i.e., https://ftp.postgresql.org/pub/projects/pgFoundry/ptop/pg_top/).
  livecheck do
    url "https://gitlab.com/pg_top/pg_top.git"
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "a8bd95ff06d4f746e3763933fee8f4118b5ae6e3d16c4a8e2ff1bc675bd4091a"
    sha256 cellar: :any, mojave:      "d31b2fb44c6d363f0f635bf6a16427968ca610ea285569bfa867bea6d0437549"
    sha256 cellar: :any, high_sierra: "32637c635d8da78d4910df2dabd474f4115c31cba57890ad053b3a43cb38a758"
    sha256 cellar: :any, sierra:      "5f06ae8b8ef1c979143e19c0527c31c8d649d23e1e9612c63bc6c5ff05bf8276"
    sha256 cellar: :any, el_capitan:  "6d0104d461d7187ad02e1085098f2dad4fa00c4f2db93b1b910a6a072517ca54"
  end

  depends_on "postgresql"

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    (buildpath/"config.h").append_lines "#define HAVE_DECL_STRLCPY 1"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/pg_top -V")
  end
end
