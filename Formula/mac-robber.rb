class MacRobber < Formula
  desc "Digital investigation tool"
  homepage "https://www.sleuthkit.org/mac-robber/"
  url "https://downloads.sourceforge.net/project/mac-robber/mac-robber/1.02/mac-robber-1.02.tar.gz"
  sha256 "5895d332ec8d87e15f21441c61545b7f68830a2ee2c967d381773bd08504806d"
  license "GPL-2.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "cb1d422835804b5ea784a2b9157ae77a0940902771397b235d4ad784b88f961a"
    sha256 cellar: :any_skip_relocation, mojave:      "e1fc7f112efeac70ca2583db78ad6436d5f6615a9959889f3e4c695aa72a27e8"
    sha256 cellar: :any_skip_relocation, high_sierra: "20c99447899b82d2da937aa81a0b3afd2c865f67a97d2ca1183e01151fef9de0"
    sha256 cellar: :any_skip_relocation, sierra:      "160983c4988cb22bd68a0beeb48de91a8af3461722a42e65e523c4a6af08f444"
    sha256 cellar: :any_skip_relocation, el_capitan:  "0647670a38eb3ae5d8085ad1126f8d70b6e9ac99b086c0ec2f3301ac51ecdb3f"
    sha256 cellar: :any_skip_relocation, yosemite:    "5e8b7656cafbab151ed82702cbd7e712ee30af62b6a6c031f9f440e95c174ed0"
    sha256 cellar: :any_skip_relocation, mavericks:   "87b8de3e43626713461398aac48d12a4b494c36b8da6cd4e6587d352fcb251fe"
  end

  def install
    system "make", "CC=#{ENV.cc}", "GCC_OPT=#{ENV.cflags}"
    bin.install "mac-robber"
  end
end
