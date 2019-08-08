class Libstatgrab < Formula
  desc "Provides cross-platform access to statistics about the system"
  homepage "https://www.i-scream.org/libstatgrab/"
  url "https://ftp.i-scream.org/pub/i-scream/libstatgrab/libstatgrab-0.92.tar.gz"
  mirror "https://www.mirrorservice.org/pub/i-scream/libstatgrab/libstatgrab-0.92.tar.gz"
  sha256 "5bf1906aff9ffc3eeacf32567270f4d819055d8386d98b9c8c05519012d5a196"

  bottle do
    cellar :any
    sha256 "c8326d6713914ba30322309ed22bf7b43a602a052d3512c77d1ddf32a05c1655" => :mojave
    sha256 "100b7116b96c56d4643954b0bb9558b77480ee03f639239b32ed331f3b51d720" => :high_sierra
    sha256 "00a91b891f940b01a5ca5d341fb6c9248da6c87312b9ecefbd0aae9cc49b62c3" => :sierra
    sha256 "5cb49282a895e5b5229a59eedaae8a7ce7517ff6d56dc4837ddbd1601b72eaa9" => :el_capitan
    sha256 "a2175221c61a952b2ed4590c1b5496dcb10d4e9547db4bba8ac69968c2c2a586" => :yosemite
    sha256 "611bd2051960ea32dcc1a814ec93638bd2feb83e76141b715cb47b28d1cc0c92" => :mavericks
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/statgrab"
  end
end
