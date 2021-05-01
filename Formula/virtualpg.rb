class Virtualpg < Formula
  desc "Loadable dynamic extension for SQLite and SpatiaLite"
  homepage "https://www.gaia-gis.it/fossil/virtualpg/index"
  url "https://www.gaia-gis.it/gaia-sins/virtualpg-1.0.2.tar.gz"
  sha256 "37abd56b2899c90b355e50d843ba019af540b83e7af1da110a766f041abb514e"

  bottle do
    sha256 cellar: :any, catalina:    "62178e004321740f4ce9ff06a9650085a8ff73f5b09594c11377c5a8b26f7b7b"
    sha256 cellar: :any, mojave:      "11f87cc36cdd1bc00799f4d877b7c25c6ffae17c32322041831cec002d927c8d"
    sha256 cellar: :any, high_sierra: "2e7d844424706349b16cbbf1f7ab6fd257703ed8de3347277090c75cadb491b8"
    sha256 cellar: :any, sierra:      "1d61bc6b83f9584e6a787b614f475177fe98472bc6fa697c1a6695dfe6f65701"
    sha256 cellar: :any, el_capitan:  "47b8d302bde32565c4b1a627041fda8df645b4349d3eb5ff250b266309d47271"
  end

  depends_on "libspatialite"
  depends_on "postgis"

  def install
    # New SQLite3 extension won't load via SELECT load_extension('mod_virtualpg');
    # unless named mod_virtualpg.dylib (should actually be mod_virtualpg.bundle)
    # See: https://groups.google.com/forum/#!topic/spatialite-users/EqJAB8FYRdI
    # needs upstream fixes in both SQLite and libtool
    inreplace "configure",
    "shrext_cmds='`test .$module = .yes && echo .so || echo .dylib`'",
    "shrext_cmds='.dylib'"

    system "./configure", "--enable-shared=yes",
                          "--disable-dependency-tracking",
                          "--with-pgconfig=#{Formula["postgresql"].opt_bin}/pg_config",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    # Verify mod_virtualpg extension can be loaded using Homebrew's SQLite
    system "echo", "\" SELECT load_extension('#{opt_lib}/mod_virtualpg');\" | #{Formula["sqlite"].opt_bin}/sqlite3"
  end
end
