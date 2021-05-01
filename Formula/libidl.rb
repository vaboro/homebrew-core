class Libidl < Formula
  desc "Library for creating CORBA IDL files"
  homepage "https://ftp.acc.umu.se/pub/gnome/sources/libIDL/0.8/"
  url "https://download.gnome.org/sources/libIDL/0.8/libIDL-0.8.14.tar.bz2"
  sha256 "c5d24d8c096546353fbc7cedf208392d5a02afe9d56ebcc1cccb258d7c4d2220"
  revision 1

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any, catalina:    "fc384a7b4357147c85196b681bd1a96a70e2a7e194c38b6e8afbef5bafc21efb"
    sha256 cellar: :any, mojave:      "6221a3b0ea37b55c26bc1f83c84ce3e027a8925b92d63055a51fe3a7d6bdff19"
    sha256 cellar: :any, high_sierra: "9b07bec68567266f1bc065b05afdb9b034c0c70548145d7cdd963b5958c8da30"
    sha256 cellar: :any, sierra:      "ecabcc1a9cd229a135557f0f8bc32a38d03d399ff6816b0fc897cc4bcf72cd1c"
  end

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "glib"

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
