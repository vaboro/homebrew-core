class Fsh < Formula
  desc "Provides remote command execution"
  homepage "https://www.lysator.liu.se/fsh/"
  url "https://www.lysator.liu.se/fsh/fsh-1.2.tar.gz"
  sha256 "9600882648966272c264cf3f1c41c11c91e704f473af43d8d4e0ac5850298826"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "d99d2e8e357b91134de9b7a47d8995ff18382ffb2ee15eb4800b2d9872294ba3"
    sha256 cellar: :any_skip_relocation, mojave:      "1600e94eda45d61acf6980d5483a7a225fd431e545b817a493c0b38b359d8cb4"
    sha256 cellar: :any_skip_relocation, high_sierra: "71abf994ecf91d4675daef2c6604e6d414d9e33c2b66b5dc6240ee44f888f442"
    sha256 cellar: :any_skip_relocation, sierra:      "13a7134ef9d20899642d8dd96e77603d74573cf3a0e1ef5063f6eefc856dbd37"
    sha256 cellar: :any_skip_relocation, el_capitan:  "cec52eb07f9db79b15ff5907f30363bbb538c01b7c4eb7ae8634e7ce17eb5431"
    sha256 cellar: :any_skip_relocation, yosemite:    "8a49ad906b045a293259c199fd5d1737894099c487b1bfc83fb60d18acf065ac"
    sha256 cellar: :any_skip_relocation, mavericks:   "ed852d51f5a0a4024d4a195c9cffd604758a11a115620a3da0975b541c912770"
  end

  def install
    # FCNTL was deprecated and needs to be changed to fcntl
    inreplace "fshcompat.py", "FCNTL", "fcntl"

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--infodir=#{info}"
    system "make", "install"
  end

  test do
    system "#{bin}/fsh", "-V"
  end
end
