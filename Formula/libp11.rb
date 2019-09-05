class Libp11 < Formula
  desc "PKCS#11 wrapper library in C"
  homepage "https://github.com/OpenSC/libp11/wiki"
  url "https://downloads.sourceforge.net/project/opensc/libp11/libp11-0.2.8.tar.gz"
  sha256 "a4121015503ade98074b5e2a2517fc8a139f8b28aed10021db2bb77283f40691"
  revision 1

  bottle do
    cellar :any
    rebuild 1
    sha256 "59aee42f309784ab654dd2e3f12d8a798fa8185f23b593c72f6f417ff9f61309" => :mojave
    sha256 "97524b39308ef2aeaa077b826e6147a3f4837c14aca2b3cd7d3d27a7210636fd" => :high_sierra
    sha256 "38a10dffaa0946c78fc0896b85475871290bff3b866bbce66d8689a0ad2a7500" => :sierra
  end

  head do
    url "https://github.com/OpenSC/libp11.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libtool"
  depends_on "openssl" # no OpenSSL 1.1 support

  def install
    system "./bootstrap" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
