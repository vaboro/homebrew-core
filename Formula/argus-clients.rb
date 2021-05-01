class ArgusClients < Formula
  desc "Audit Record Generation and Utilization System clients"
  homepage "https://qosient.com/argus/"
  url "https://qosient.com/argus/src/argus-clients-3.0.8.2.tar.gz"
  sha256 "32073a60ddd56ea8407a4d1b134448ff4bcdba0ee7399160c2f801a0aa913bb1"
  revision 4

  bottle do
    sha256 cellar: :any, catalina:    "579d10c6b410d1fe18fb653c6413a30ea04f8826f441094bcb944244e9dfdfd5"
    sha256 cellar: :any, mojave:      "ed00932e81d23c0a2cb872190088994a190967f4bbe8dc08e9f04212e6ede2e0"
    sha256 cellar: :any, high_sierra: "3c231bbc8dccff67f8eadb490bb128bbf063e9200993d53d0306e1730ea0bc5e"
    sha256 cellar: :any, sierra:      "edfae9718df8bd3d4fe6225cca8170513638b1581234fffa8deaa5f9e228593d"
  end

  depends_on "geoip"
  depends_on "readline"
  depends_on "rrdtool"

  def install
    ENV.append "CFLAGS", "-std=gnu89"
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "Ra Version #{version}", shell_output("#{bin}/ra -h", 1)
  end
end
