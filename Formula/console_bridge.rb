class ConsoleBridge < Formula
  desc "Robot Operating System-independent package for logging"
  homepage "https://wiki.ros.org/console_bridge/"
  url "https://github.com/ros/console_bridge/archive/1.0.1.tar.gz"
  sha256 "2ff175a9bb2b1849f12a6bf972ce7e4313d543a2bbc83b60fdae7db6e0ba353f"
  license "BSD-3-Clause"

  bottle do
    sha256 cellar: :any, catalina:    "0b499b94d9a1f14aebdbcdbfb21d95ce06a9c2a9160ecf317541bef7c76a1324"
    sha256 cellar: :any, mojave:      "a8fe261af6240d0a5128c4a9d214457bc0f0d20b198172c8a84e95d9ffa3fbd9"
    sha256 cellar: :any, high_sierra: "0be0e4bb4c6a14c7f8725dc44443b5772e4b4a5b9da1df521cfb4d18d88c9437"
  end

  depends_on "cmake" => :build

  def install
    ENV.cxx11
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <console_bridge/console.h>
      int main() {
        CONSOLE_BRIDGE_logDebug("Testing Log");
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lconsole_bridge", "-std=c++11",
                    "-o", "test"
    system "./test"
  end
end
