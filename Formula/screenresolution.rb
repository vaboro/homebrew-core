class Screenresolution < Formula
  desc "Get, set, and list display resolution"
  homepage "https://github.com/jhford/screenresolution"
  url "https://github.com/jhford/screenresolution/archive/v1.6.tar.gz"
  sha256 "d3761663eaf585b014391a30a77c9494a6404e78e8a4863383e12c59b0f539eb"
  license "GPL-2.0"
  head "https://github.com/jhford/screenresolution.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "53636977689925be4ef97933dc0f1b411f0cd82f71a268cfe7c6f90d5a294f97"
    sha256 cellar: :any_skip_relocation, mojave:      "15d61e87178dbe8ef88c9cb75251f472efc42830b1a2c5be25e4a5bd074e0c66"
    sha256 cellar: :any_skip_relocation, high_sierra: "b2f7b0933c734d5ecd8bfafae8d384f20821c45ca38fc81308035d3ca79f3535"
    sha256 cellar: :any_skip_relocation, sierra:      "ef630f5af67d6bcdde3fd580917ad05d871274f0d62b2a76705ab2b9683f334f"
    sha256 cellar: :any_skip_relocation, el_capitan:  "63cfb53fe13d5f5b2c72e8a644b312f8a144b12e2b3f284de5adfc5010e1570d"
    sha256 cellar: :any_skip_relocation, yosemite:    "3b3f5d4c414aa36ee1ce963d47a82a50e06f1ffc7a36759bf13ee12c43845c73"
    sha256 cellar: :any_skip_relocation, mavericks:   "9e6944af938c0c9ec9e1e4a79a6849fabb222baa0d977a9425bee6a2827595d0"
  end

  def install
    system "make", "CC=#{ENV.cc}"
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system "#{bin}/screenresolution", "get"
  end
end
