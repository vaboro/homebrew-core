class Agedu < Formula
  desc "Unix utility for tracking down wasted disk space"
  homepage "https://www.chiark.greenend.org.uk/~sgtatham/agedu/"
  url "https://www.chiark.greenend.org.uk/~sgtatham/agedu/agedu-20200705.2a7d4a2.tar.gz"
  version "20200705"
  sha256 "432dd9602df326088956b3e4f5efe656ad09777873d38695e0d68810899941c2"
  head "https://git.tartarus.org/simon/agedu.git"

  livecheck do
    url :homepage
    regex(/href=.*?agedu[._-]v?(\d+)(?:\.[\da-z]+)?\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "d5b1ceb8b45632543c913d12641cb820335b0e99fd823c9404222f0e087edef4"
    sha256 cellar: :any_skip_relocation, mojave:      "bb054128df68140a5cf8b7359a7d7c6357b13c08aa393b9481ff89124e614544"
    sha256 cellar: :any_skip_relocation, high_sierra: "64a0584a579b71db75866548df7fef3eb7eb460023f3959aaf5e1c4d9e23bca8"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "halibut" => :build

  def install
    system "./mkauto.sh"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"agedu", "-s", "."
    assert_predicate testpath/"agedu.dat", :exist?
  end
end
