class Ipmiutil < Formula
  desc "IPMI server management utility"
  homepage "https://ipmiutil.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/ipmiutil/ipmiutil-3.1.7.tar.gz"
  sha256 "911fd6f8b33651b98863d57e678d2fc593bc43fcd2a21f5dc7d5db8f92128a9a"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "ad8fc089b714a2286884168e7ce78e4cfb9a2c045e7daf9ee77eae3524bb0f8f"
    sha256 cellar: :any_skip_relocation, mojave:      "af41d4e3592cea0b3151276cff34bfabc810b47af165dc16436e8af30877e52e"
    sha256 cellar: :any_skip_relocation, high_sierra: "502b711bfa0411d970ac6fc5dabd65e04a0a80b0bf0adead2fa1e965f2079050"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "openssl@1.1"

  conflicts_with "renameutils", because: "both install `icmd` binaries"

  def install
    # Darwin does not exist only on PowerPC
    inreplace "configure.ac", "test \"$archp\" = \"powerpc\"", "true"
    system "autoreconf", "-fiv"

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-sha256",
                          "--enable-gpl"

    system "make", "TMPDIR=#{ENV["TMPDIR"]}"
    # DESTDIR is needed to make everything go where we want it.
    system "make", "prefix=/",
                   "DESTDIR=#{prefix}",
                   "varto=#{var}/lib/#{name}",
                   "initto=#{etc}/init.d",
                   "sysdto=#{prefix}/#{name}",
                   "install"
  end

  test do
    system "#{bin}/ipmiutil", "delloem", "help"
  end
end
