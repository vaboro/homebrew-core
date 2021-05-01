class GitDelta < Formula
  desc "Syntax-highlighting pager for git and diff output"
  homepage "https://github.com/dandavison/delta"
  url "https://github.com/dandavison/delta/archive/0.4.3.tar.gz"
  sha256 "78ee36ec30194fe261ccb585111b67adae5166e79170f9636e54cbf5427da54a"
  license "MIT"
  head "https://github.com/dandavison/delta.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "ef07bc394646ce496f4df2187a190d9462911309484859eb673a898afe5cd245"
    sha256 cellar: :any_skip_relocation, mojave:      "766eb46b081280cb6db0e7a18b0af23061de6bc36a17424b9389d044b9f395a9"
    sha256 cellar: :any_skip_relocation, high_sierra: "a21ba72f6937355d553b634caf3498edcd87c3329e134d1ceeaddb6490ba27ea"
  end

  depends_on "rust" => :build
  uses_from_macos "llvm"

  conflicts_with "delta", because: "both install a `delta` binary"

  def install
    ENV.append_to_cflags "-fno-stack-check" if DevelopmentTools.clang_build_version >= 1010
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "delta #{version}", `#{bin}/delta --version`.chomp
  end
end
