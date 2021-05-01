class Scmpuff < Formula
  desc "Adds numbered shortcuts for common git commands"
  homepage "https://mroth.github.io/scmpuff/"
  url "https://github.com/mroth/scmpuff/archive/v0.3.0.tar.gz"
  sha256 "239cd269a476f5159a15ef462686878934617b11317fdc786ca304059c0b6a0b"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "3e191a0aa602fb00cd35bc729261b2b377472b7f8add3d56263680d11ac7183b"
    sha256 cellar: :any_skip_relocation, mojave:      "304cb27623cc21878468793b8b8375a8a89f4f050cda665d301ecc025690e712"
    sha256 cellar: :any_skip_relocation, high_sierra: "604d1805e793cbf6e0b07e030389a0275ccc98db832ff7564522496302e04985"
    sha256 cellar: :any_skip_relocation, sierra:      "15a2fd8febc6ac36cb3429979fd5c8f88f230ae6276c073a0eedc5ac7e7abf69"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"
    (buildpath/"src/github.com/mroth/scmpuff").install buildpath.children
    cd "src/github.com/mroth/scmpuff" do
      system "go", "build", "-ldflags", "-X main.VERSION=#{version}",
                   "-o", bin/"scmpuff"
      prefix.install_metafiles
    end
  end

  test do
    ENV["e1"] = "abc"
    assert_equal "abc", shell_output("#{bin}/scmpuff expand 1").strip
  end
end
