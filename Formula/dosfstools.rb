class Dosfstools < Formula
  desc "Tools to create, check and label file systems of the FAT family"
  homepage "https://github.com/dosfstools"
  license "GPL-3.0"
  head "https://github.com/dosfstools/dosfstools.git"

  stable do
    url "https://github.com/dosfstools/dosfstools/releases/download/v4.1/dosfstools-4.1.tar.gz"
    sha256 "dc49997fd9fcd6e550c1a0dd5f97863d6ded99d465c33633a2b8769f4d72a137"

    # This patch restores the old defaults in versions up to v3.0.28
    patch do
      url "https://github.com/dosfstools/dosfstools/commit/1e76e577.patch?full_index=1"
      sha256 "7dafc9e5642f8c1f316ac9dedbc0e4becf198b582b255b53bdf45b8de84bf6b6"
    end
  end
  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:    "c537f560096a325d904edb80218af9c113ad365ae3c39c9b1b3393aa38418885"
    sha256 cellar: :any_skip_relocation, mojave:      "a12605487c15e462c7ae652bb3f1587d254fc0001bfbae9261903c9f85542c2e"
    sha256 cellar: :any_skip_relocation, high_sierra: "44d8a1baa92d553ec9c24c1152c875b0f7d3730146d3decf4cdfa8f7b1516434"
    sha256 cellar: :any_skip_relocation, sierra:      "b14dc5d79955f0ee586a33c7e265df2def55b1c64b7eb123539fce827cdeb6ec"
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build

  def install
    system "autoreconf", "-f", "-i"
    system "./configure", "--prefix=#{prefix}", "--without-udev",
                          "--enable-compat-symlinks"
    system "make", "install"
  end

  test do
    system "dd", "if=/dev/zero", "of=test.bin", "bs=512", "count=1024"
    system "#{sbin}/mkfs.fat", "test.bin", "-n HOMEBREW", "-v"
    system "#{sbin}/fatlabel", "test.bin"
    system "#{sbin}/fsck.fat", "-v", "test.bin"
  end
end
