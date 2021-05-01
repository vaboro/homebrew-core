class Yj < Formula
  desc "CLI to convert between YAML, TOML, JSON and HCL"
  homepage "https://github.com/sclevine/yj"
  url "https://github.com/sclevine/yj/archive/v5.0.0.tar.gz"
  sha256 "df9a4f5b6d067842ea3da68ff92c374b98560dce1086337d39963a1346120574"
  license "Apache-2.0"
  head "https://github.com/sclevine/yj.git"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:    "918450aaf162067fe6fa7979518a7fc998853a4ab215c01f2c69e756739fb710"
    sha256 cellar: :any_skip_relocation, mojave:      "918450aaf162067fe6fa7979518a7fc998853a4ab215c01f2c69e756739fb710"
    sha256 cellar: :any_skip_relocation, high_sierra: "918450aaf162067fe6fa7979518a7fc998853a4ab215c01f2c69e756739fb710"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags", "-X main.Version=#{version}", *std_go_args
  end

  test do
    assert_match '{"a":1}', shell_output("echo a=1|#{bin}/yj -t")
  end
end
