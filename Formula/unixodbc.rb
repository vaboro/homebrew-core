class Unixodbc < Formula
  desc "ODBC 3 connectivity for UNIX"
  homepage "http://www.unixodbc.org/"
  url "http://www.unixodbc.org/unixODBC-2.3.9.tar.gz"
  sha256 "52833eac3d681c8b0c9a5a65f2ebd745b3a964f208fc748f977e44015a31b207"
  license "LGPL-2.1-or-later"

  livecheck do
    url "http://www.unixodbc.org/download.html"
    regex(/href=.*?unixODBC[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 catalina:    "b312633496b3b92a61751508d0c35b7053a1cf202aedae79d2609cf6dfdede27"
    sha256 mojave:      "f52d9ff5a13e7e78560cead35ca4a3d17e4582e791319c6c15d47ac8ac6f63d4"
    sha256 high_sierra: "f7bbaf85f41df090d7ea6c8103543ec2890164ef43c4c2bdb7cef13c0993585d"
  end

  depends_on "libtool"

  conflicts_with "libiodbc", because: "both install `odbcinst.h`"
  conflicts_with "virtuoso", because: "both install `isql` binaries"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--enable-static",
                          "--enable-gui=no"
    system "make", "install"
  end

  test do
    system bin/"odbcinst", "-j"
  end
end
