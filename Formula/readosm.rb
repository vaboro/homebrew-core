class Readosm < Formula
  desc "Extract valid data from an Open Street Map input file"
  homepage "https://www.gaia-gis.it/fossil/readosm/index"
  url "https://www.gaia-gis.it/gaia-sins/readosm-1.1.0.tar.gz"
  sha256 "c508cde9c49b955613d9a30dcf622fa264a5c0e01f58074e93351ea39abd40ec"

  livecheck do
    url :homepage
    regex(/href=.*?readosm[._-]v?(\d+(?:\.\d+)+[a-z]?)\.t/i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "aa0cbf07d9ba38940bf4a594dcfdcc9b915c64b9b6a1eb79907cb6d84c28d267"
    sha256 cellar: :any, mojave:      "9267299755eb50ddd6330cafba8d81d8a0ee48821414162ef767bb4a7a2d4195"
    sha256 cellar: :any, high_sierra: "953aeb6917d8ad465d11d2832ac4ba20fd673c694562fdca9ccf7cef0346d280"
    sha256 cellar: :any, sierra:      "98fc0238ad218a95df4bea4a3520f84fc66f9dc8bba3e0b6ad7fa774813f16e8"
    sha256 cellar: :any, el_capitan:  "3637140ac264e9fc4e7cd8e78e1754d5b6861ef98d7ae38ba7e70c9825241069"
  end

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
    doc.install "examples"
  end

  test do
    system ENV.cc, "-I#{include}", "-L#{lib}", "-lreadosm",
           doc/"examples/test_osm1.c", "-o", testpath/"test"
    assert_equal "usage: test_osm1 path-to-OSM-file",
                 shell_output("./test 2>&1", 255).chomp
  end
end
