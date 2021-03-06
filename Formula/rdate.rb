class Rdate < Formula
  desc "Set the system's date from a remote host"
  homepage "https://www.aelius.com/njh/rdate/"
  url "https://www.aelius.com/njh/rdate/rdate-1.5.tar.gz"
  sha256 "6e800053eaac2b21ff4486ec42f0aca7214941c7e5fceedd593fa0be99b9227d"
  license "GPL-2.0"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:    "68597f7989ddba1ff853f54c0cf3adf36b3567268b69ca43d7b0795d290304b4"
    sha256 cellar: :any_skip_relocation, mojave:      "2d4c93b21caa56d3228d8ff2ff790f4142421ad6316cd74d77c568e84602a996"
    sha256 cellar: :any_skip_relocation, high_sierra: "02e41a79e9aca3bad86802e1bc32c7148e8a2ea2f410c57765f9e9d8b2686fd1"
    sha256 cellar: :any_skip_relocation, sierra:      "9f4a6300d6d3ebc9034abeb5388fd40face1f286a7b97610b6a40a1dcdf166b5"
    sha256 cellar: :any_skip_relocation, el_capitan:  "acb2ae5951a0f32cbdce39e02d86c63cdb85b41fd02aff74aac6ea4939d71d8d"
    sha256 cellar: :any_skip_relocation, yosemite:    "553782017635be9c8d80bbf6fd033f294cddcb427a2d83fe82af8c069c60867f"
    sha256 cellar: :any_skip_relocation, mavericks:   "3a36b6feccd119c90db3373a3de1b67f4aa03fc72aacdf7b11165b538206ae14"
  end

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--mandir=#{man}"
    system "make", "install"
  end

  test do
    # NOTE: that the server must support RFC 868
    system "#{bin}/rdate", "-p", "-t", "10", "time-b-b.nist.gov"
  end
end
