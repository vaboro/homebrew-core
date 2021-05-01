class Ttyplot < Formula
  desc "Realtime plotting utility for terminal with data input from stdin"
  homepage "https://github.com/tenox7/ttyplot"
  url "https://github.com/tenox7/ttyplot/archive/1.4.tar.gz"
  sha256 "11974754981406d19cfa16865b59770faaf3ade8d909d9a0134dc56e00d29bd4"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "760b571d2cc940c6a1ad14655f2e2c0cac4aa64dea8e63d37454528cf969d8b2"
    sha256 cellar: :any_skip_relocation, mojave:      "b31388536afde7ef669c334f520e73f95ceef82d0c9f73f5390a65d13d3235ef"
    sha256 cellar: :any_skip_relocation, high_sierra: "6d01769af5216ac128e8cb9a0a55397959594fa8f20fafcf65780db4b66ac090"
  end

  uses_from_macos "ncurses"

  def install
    system "make"
    bin.install "ttyplot"
  end

  test do
    system "#{bin}/ttyplot", "--help"
    # ttyplot normally reads data over time:
    # piping lines to it will just let it start and immediately exit successfully.
    system "echo 1 2 3 | #{bin}/ttyplot"
  end
end
