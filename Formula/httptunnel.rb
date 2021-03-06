class Httptunnel < Formula
  desc "Tunnels a data stream in HTTP requests"
  homepage "https://github.com/larsbrinkhoff/httptunnel"
  url "https://ftp.gnu.org/gnu/httptunnel/httptunnel-3.3.tar.gz"
  mirror "https://ftpmirror.gnu.org/httptunnel/httptunnel-3.3.tar.gz"
  sha256 "142f82b204876c2aa90f19193c7ff78d90bb4c2cba99dfd4ef625864aed1c556"
  license "GPL-2.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "992853ebe7a48e07cf6e129d68cab49aab670ce4231a4a984ded21ece64247c0"
    sha256 cellar: :any_skip_relocation, mojave:      "b6072c89e94ba53852f28c25ec85e6bdb24e7ebbce7eee35b418c9d609e68670"
    sha256 cellar: :any_skip_relocation, high_sierra: "6012d5967ab7263658ce1da99ee7bbdd051e37243b922b0702f4279ed047c014"
    sha256 cellar: :any_skip_relocation, sierra:      "64b548d12c4e3012cb9d8d9f5171e0fc47e594c13f4d4ae35c5f97be1582b263"
    sha256 cellar: :any_skip_relocation, el_capitan:  "b328d4e1f1e2638764d3ac2ed32a4f4e06935e4e9ef83af281936df4ab805aa5"
    sha256 cellar: :any_skip_relocation, yosemite:    "54fbed6b247d143f05c50c2202b5ff447f90504553431e7a143f6178893f148c"
    sha256 cellar: :any_skip_relocation, mavericks:   "dcec84a118e1e7246d29ccc12397b7aa0134e1a2a952aa83af7b4ba6745318ac"
  end

  def install
    system "./configure", "--prefix=#{prefix}", "--mandir=#{man}"
    system "make", "install"
  end

  test do
    pid = fork do
      exec "#{bin}/hts --stdin-stdout --pid-file #{testpath}/pid 8081"
    end
    sleep 2

    begin
      assert_predicate testpath/"pid", :exist?
    ensure
      Process.kill "SIGINT", pid
      Process.wait pid
    end
  end
end
