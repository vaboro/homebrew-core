class Libusrsctp < Formula
  desc "Portable SCTP userland stack"
  homepage "https://github.com/sctplab/usrsctp"
  url "https://github.com/sctplab/usrsctp/archive/0.9.3.0.tar.gz"
  sha256 "a4573b1cd7b8fc2fce476df61093736d3fea9eef5c87d72e66768c0a6b1f9e39"
  license "BSD-3-Clause"
  head "https://github.com/sctplab/usrsctp.git"

  bottle do
    sha256 cellar: :any, catalina:    "de21e0c3c332c8fe847ad292d047168a9c3598c613a6a8f1f3e42082c15d9150"
    sha256 cellar: :any, mojave:      "a7f2fe014d976dc839bdad57f3ac07a9c11683e683643c2de76c9036f87e61f9"
    sha256 cellar: :any, high_sierra: "8914ab47dadb25cf626662cde57d10f10a99915b4848d0302c92a61b40842c3f"
    sha256 cellar: :any, sierra:      "7d210faa7eb0101915c2f918ac0479c7bfc5faa251b389dfea68d94385823499"
    sha256 cellar: :any, el_capitan:  "c11f1c4bb7ee3b7d04520d711dfac56bc5a2aa8f4b3f1e952bd591d9918528dd"
    sha256 cellar: :any, yosemite:    "2998a0f18ca069da692c9c2fd44f52e5ed9fa39c223dec3e8df7206f113bc0f4"
    sha256 cellar: :any, mavericks:   "8fc00b935739b4e06e75773c780e7e9617d655ecf2e31ffa9ca46900c1bbd5cb"
  end

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <unistd.h>
      #include <usrsctp.h>
      int main() {
        usrsctp_init(0, NULL, NULL);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lusrsctp", "-o", "test"
    system "./test"
  end
end
