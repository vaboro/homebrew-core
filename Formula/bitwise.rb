class Bitwise < Formula
  desc "Terminal based bit manipulator in ncurses"
  homepage "https://github.com/mellowcandle/bitwise"
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://github.com/mellowcandle/bitwise/releases/download/v0.33/bitwise-v0.33.tar.gz"
  sha256 "598a623d9befaf1e724d78406a93140c1fc05ba9526f11bee945d236a92572c8"

  bottle do
    cellar :any
    sha256 "ca1fe56e701f249f78cf606a418257c2e5ef39f7de2c6a4b8426b3dfc5a7ef5e" => :mojave
    sha256 "24c4effd91b4f596576ebb8f92966195233f353fd5dd2daf4f774b8e7eeccf50" => :high_sierra
    sha256 "787986ce6174a4a564ef8b63c2535a84c674fd0f6bcd2863f00eb3e9019d3ee2" => :sierra
=======
  url "https://github.com/mellowcandle/bitwise/releases/download/v0.40/bitwise-v0.40.tar.gz"
  sha256 "d74585153d8ae605fd9bb23d2a4b57ed5df283f902d376d0d31ade95423afa03"

  bottle do
    cellar :any
    sha256 "c78b42bffab47e12d4c98d97c47e14e9809e08fce3921cef84ae7f038fb1159a" => :mojave
    sha256 "0a3bd971b0473b8f863158df2f7176eb90b1da390840e43433f660bd62e006da" => :high_sierra
    sha256 "5b63274d741baf311a5e7409d42e5e63854ac5e5852c12e5ee08ba98572393d1" => :sierra
>>>>>>> upstream/master
=======
  url "https://github.com/mellowcandle/bitwise/releases/download/v0.41/bitwise-v0.41.tar.gz"
  sha256 "33ce934fb99dadf7652224152cc135a0abf6a211adde53d96e9be7067567749c"
  license "GPL-3.0"

  bottle do
    cellar :any
    sha256 "d7d90a1402b7b87e1989b2504e6c55ea5bea27282f4bf909b6248aac2d5263cd" => :catalina
    sha256 "95674ac94d09b5502765956cc94b5f1a9687f22f145e2757bd708f7f7613f913" => :mojave
    sha256 "e5e76e2ec3f762a6c79b52552fb5513bc891e55831aa75806f61b75834369d6d" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "readline"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"

    system "make", "install"
  end

  test do
    assert_match "0 0 1 0 1 0 0 1", shell_output("#{bin}/bitwise --no-color '0x29A >> 4'")
  end
end
