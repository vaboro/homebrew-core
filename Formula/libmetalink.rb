class Libmetalink < Formula
  desc "C library to parse Metalink XML files"
  homepage "https://launchpad.net/libmetalink/"
  url "https://launchpad.net/libmetalink/trunk/libmetalink-0.1.3/+download/libmetalink-0.1.3.tar.xz"
  sha256 "86312620c5b64c694b91f9cc355eabbd358fa92195b3e99517504076bf9fe33a"
  license "MIT"

  livecheck do
    url :stable
    regex(%r{<div class="version">\s*Latest version is libmetalink[._-]v?(\d+(?:\.\d+)+)\s*</div>}i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "a18e6199b4d775a32693aa38b80551d547eb1de58c5d7c788f706276ce296d5e"
    sha256 cellar: :any, mojave:      "461d42fab1dd15b7df8144ef814a3b589c5be9177728b522ea73e6c52bec660f"
    sha256 cellar: :any, high_sierra: "037c9d82da0a2c77031515cc8618b28552c526e559b3d9cebb0f054cd66204e3"
    sha256 cellar: :any, sierra:      "87711da9c52d75d2d6fed5829a70b0f6561f55fdcf1129266001b6e96bc69b1b"
    sha256 cellar: :any, el_capitan:  "4ca3f82ac2e2520c677def661168c6ba14ee2b8f0139fbe33cf5be66745244d3"
    sha256 cellar: :any, yosemite:    "e627cde406e135a735fd2586622d2fa05cf6ef9fda8a0ea08d09ddfce20dca75"
    sha256 cellar: :any, mavericks:   "9ff31fac7dcd9f9231c067eff04d9b59e1de9f8416142d519799746dbfa34c24"
  end

  depends_on "pkg-config" => :build

  uses_from_macos "expat"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end
end
