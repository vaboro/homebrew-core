class Ttyd < Formula
  desc "Command-line tool for sharing terminal over the web"
  homepage "https://tsl0922.github.io/ttyd/"
<<<<<<< HEAD
  url "https://github.com/tsl0922/ttyd/archive/1.5.2.tar.gz"
  sha256 "b5b62ec2ce08add0173e6d1dfdd879e55f02f9490043e89f389981a62e87d376"
<<<<<<< HEAD
=======
  revision 2
>>>>>>> upstream/master
=======
  url "https://github.com/tsl0922/ttyd/archive/1.6.1.tar.gz"
  sha256 "d72dcca3dec00cda87b80a0a25ae4fee2f8b9098c1cdb558508dcb14fbb6fafc"
  license "MIT"
  revision 1
>>>>>>> upstream/master
  head "https://github.com/tsl0922/ttyd.git"

  bottle do
    cellar :any
<<<<<<< HEAD
<<<<<<< HEAD
    sha256 "7e45c24f3146519cfc50dee0c88b79d3f990dc883607d3736b92bf54e61f556c" => :mojave
    sha256 "b06844f79f440bdd9ad490b167d98633bc68a8ffdc94297ebbd89634017f189f" => :high_sierra
    sha256 "ff1bc58472594657ccbd57aeb7efbc84b896a255d475013d9897081c62220028" => :sierra
=======
    sha256 "01c301e0e4faf1a27f8964d46d311720dafe4d133b1848bbbd0eb747335c10ef" => :mojave
    sha256 "543808131b2d38d1bf1eafa7b547ffd9b141e9b264cad86aeb3f91a89a2373d8" => :high_sierra
    sha256 "a3c16fa7dfe029cad28bfe5fe79e063401e7ba08f6d1e7b59620aeae1f81f166" => :sierra
>>>>>>> upstream/master
=======
    sha256 "97098f5b98c13ae80374fe41c1955ada4382449e3be7f08984b843c439be18b5" => :catalina
    sha256 "34d7eceee16997bd2ffdbba37951b706c9e0a5cbc27761e832be71af7c0b18c9" => :mojave
    sha256 "00276ef8a5190eb11920cacaa23d940f66032ab2267b19839531876097f38f64" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "cmake" => :build
  depends_on "json-c"
  depends_on "libevent"
  depends_on "libuv"
  depends_on "libwebsockets"
  depends_on "openssl@1.1"

  uses_from_macos "vim"

  def install
    system "cmake", ".",
                    *std_cmake_args,
                    "-DOPENSSL_ROOT_DIR=#{Formula["openssl@1.1"].opt_prefix}"
    system "make", "install"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ttyd --version")
  end
end
