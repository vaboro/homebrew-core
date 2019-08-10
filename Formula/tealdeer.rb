class Tealdeer < Formula
  desc "Very fast implementation of tldr in Rust"
  homepage "https://github.com/dbrgn/tealdeer"
  url "https://github.com/dbrgn/tealdeer/archive/v1.2.0.tar.gz"
  sha256 "5cf286059b823501d05da445b9b7a609ec2da91d711d990df76397f79d800c52"

  bottle do
    sha256 "788e57ff6bf20cb0c43513d1b3ecd444ce4c880e5504a7865b47f01ec53a68db" => :mojave
    sha256 "a8de8c1172dee32c86825b24cc1a85e24265d535ee150c553ab023d9abef1a74" => :high_sierra
    sha256 "957602ffd92a10f6928efa1674e49301058878aaf62f961c5c2d4b4b27e14dae" => :sierra
  end

  depends_on "rust" => :build

  conflicts_with "tldr", :because => "both install `tldr` binaries"

  def install
    system "cargo", "install", "--root", prefix,
                               "--path", "."
    bash_completion.install "bash_tealdeer"
  end

  test do
    assert_match "brew", shell_output("#{bin}/tldr -u && #{bin}/tldr brew")
  end
end
