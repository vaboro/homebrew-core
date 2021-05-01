class CargoC < Formula
  desc "Helper program to build and install c-like libraries"
  homepage "https://github.com/lu-zero/cargo-c"
  url "https://github.com/lu-zero/cargo-c/archive/v0.6.13.tar.gz"
  sha256 "aa6b23c7ae19ec93e6edeb59be46056faccb915a02d1784a0c29ac7a3c6a8aea"
  license "MIT"

  bottle do
    sha256 cellar: :any, catalina:    "33d7a87e571d69c096bbbd076aaf721ddf79891df0296ac089fd48aedc95cee5"
    sha256 cellar: :any, mojave:      "4ef28124d155da49a405587017b27bcd57571a2095879ff06565d9ea49243c12"
    sha256 cellar: :any, high_sierra: "78c86f143a59ff7d136ecc0eeb01390624dd85afe7833dc34ac07055ac76d4a0"
  end

  depends_on "rust" => :build
  depends_on "libgit2"
  depends_on "libssh2"
  depends_on "openssl@1.1"

  on_linux do
    depends_on "pkg-config" => :build
  end

  def install
    ENV["LIBGIT2_SYS_USE_PKG_CONFIG"] = "1"
    ENV["LIBSSH2_SYS_USE_PKG_CONFIG"] = "1"

    system "cargo", "install", *std_cargo_args
  end

  test do
    cargo_error = "could not find `Cargo.toml`"
    assert_match cargo_error, shell_output("#{bin}/cargo-cinstall cinstall 2>&1", 1)
    assert_match cargo_error, shell_output("#{bin}/cargo-cbuild cbuild 2>&1", 1)
  end
end
