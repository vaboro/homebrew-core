class LibbitcoinExplorer < Formula
  desc "Bitcoin command-line tool"
  homepage "https://github.com/libbitcoin/libbitcoin-explorer"
  url "https://github.com/libbitcoin/libbitcoin-explorer/archive/v3.6.0.tar.gz"
<<<<<<< HEAD
  sha256 "20c8ccc30b090309bee2b13a4b07f17ae6b16421dac804423f034c32dc1c518c"

  bottle do
    sha256 "f1bdfac54c27695fd9f54ca3f44a1501a2ae006ed33cbca7ae6f80340459351a" => :mojave
    sha256 "429b1eb703fc481d1866918302320bea542535c795fffeb3bb9192e6767f2bd9" => :high_sierra
    sha256 "63186c9185d9b5b3daad3188a5bff986b41d1b5e24b7770f62ad13f88ab94891" => :sierra
=======
  sha256 "e1b3fa2723465f7366a6e8c55e14df53106e90b82cc977db638c78f9bc5c47db"
  license "AGPL-3.0"
  revision 4

  bottle do
<<<<<<< HEAD
<<<<<<< HEAD
    sha256 "94d6e2dee3f840e3f34bfbbceeac8b96d96af59d82324dab06c64a23ba097b56" => :mojave
    sha256 "be77db655222b492d67542472f72d52921eccd05ff8c1726e10c0984e72196f2" => :high_sierra
    sha256 "7866d2a23aa9e89474d4a03281ddecfe7f3e6962286758c2dd182de6e3af236c" => :sierra
>>>>>>> upstream/master
=======
    sha256 "41848d34f2e61b546b6eddeaea5f2c78f807e550495704925c52b1d0cdec8039" => :mojave
    sha256 "1e7087e8f4468f9e5a23740dad4545a35fc94b255fbd2a8c2eefa4f60b6e2e09" => :high_sierra
    sha256 "d2b4d343f9bc7d7a09e481b2d26b7cf0283a8cc717d92e02266ca7c48fb4bf12" => :sierra
>>>>>>> upstream/master
=======
    sha256 "75d106ae90e93f8b06f1db2e79bed2dac2cf2a8e1f0da5dc45844b7a531424f8" => :catalina
    sha256 "b0ebcf8e94695fcc4f2acccd527dbdb8479e3d3942588c93f931d84ea93899e8" => :mojave
    sha256 "76f237988d3dde9024eb66c5e98535017c717e610cbaae3e235b7938e0f29b3d" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "libbitcoin-client"
  depends_on "libbitcoin-network"

  def install
    ENV.prepend_path "PKG_CONFIG_PATH", Formula["libbitcoin"].opt_libexec/"lib/pkgconfig"

    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"

    bash_completion.install "data/bx"
  end

  test do
    seed = "7aaa07602b34e49dd9fd13267dcc0f368effe0b4ce15d107"
    expected_private_key = "5b4e3cba38709f0d80aff509c1cc87eea9dad95bb34b09eb0ce3e8dbc083f962"
    expected_public_key = "023b899a380c81b35647fff5f7e1988c617fe8417a5485217e653cda80bc4670ef"
    expected_address = "1AxX5HyQi7diPVXUH2ji7x5k6jZTxbkxfW"

    private_key = shell_output("#{bin}/bx ec-new #{seed}").chomp
    assert_equal expected_private_key, private_key

    public_key = shell_output("#{bin}/bx ec-to-public #{private_key}").chomp
    assert_equal expected_public_key, public_key

    address = shell_output("#{bin}/bx ec-to-address #{public_key}").chomp
    assert_equal expected_address, address
  end
end
