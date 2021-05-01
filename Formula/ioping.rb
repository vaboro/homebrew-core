class Ioping < Formula
  desc "Tool to monitor I/O latency in real time"
  homepage "https://github.com/koct9i/ioping"
  url "https://github.com/koct9i/ioping/archive/v1.2.tar.gz"
  sha256 "d3e4497c653a1e96df67c72ce2b70da18e9f5e3b93179a5bb57a6e30ceacfa75"
  license "GPL-3.0"
  head "https://github.com/koct9i/ioping.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "622678afe9bf88bae08cc264dece76f0abefc854915f5b3d5355cde767aa61e1"
    sha256 cellar: :any_skip_relocation, mojave:      "4c88038d68f17bbc405c5ed253542890e0fc1e44ece8650f1a68b6ff6df7fabf"
    sha256 cellar: :any_skip_relocation, high_sierra: "9a5ee7cd526c89d70c75fe6fcf61d7b0a777d8bf3a823fe99348864a9838b6ff"
  end

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/ioping", "-c", "1", testpath
  end
end
