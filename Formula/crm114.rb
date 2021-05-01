class Crm114 < Formula
  desc "Examine, sort, filter or alter logs or data streams"
  homepage "https://crm114.sourceforge.io/"
  url "https://crm114.sourceforge.io/tarballs/crm114-20100106-BlameMichelson.src.tar.gz"
  sha256 "fb626472eca43ac2bc03526d49151c5f76b46b92327ab9ee9c9455210b938c2b"

  bottle do
    sha256 cellar: :any, catalina:    "f6ebd35ffbae26d9cf77de3f165c13ec170b8123d527369f43e9a862f14eb287"
    sha256 cellar: :any, mojave:      "38a8c208a23dc67027eb63e9a8a6782cdb0763caa061fbf74525003d028d0558"
    sha256 cellar: :any, high_sierra: "1871f19d45d9d9d5f84663acde3f7e9177fd9a44bfe50532ed123314e360f690"
    sha256 cellar: :any, sierra:      "5e22ac9266e49f8281f3afbd613b3f16eb76113fc1f1e2256206513ab6220d42"
    sha256 cellar: :any, el_capitan:  "d48449acfcd105d07e11c0ac7c47fdb21b88d3346c0b51377b9e44b8c8726073"
    sha256 cellar: :any, yosemite:    "151316bd14f7cfce5cea3b765cf4e7801e31c63b72dd786fb38989d8b9380eb3"
    sha256 cellar: :any, mavericks:   "30c0c390671485747b7fd2e19bd8735ccfe3bfaae8864dc361bf2abe917ba342"
  end

  depends_on "tre"

  def install
    ENV.append "CFLAGS", "-std=gnu89"
    inreplace "Makefile", "LDFLAGS += -static -static-libgcc", ""
    bin.mkpath
    system "make", "prefix=#{prefix}", "install"
  end
end
