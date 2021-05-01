class Ephemeralpg < Formula
  desc "Run tests on an isolated, temporary Postgres database"
  homepage "https://eradman.com/ephemeralpg/"
  url "https://eradman.com/ephemeralpg/code/ephemeralpg-3.0.tar.gz"
  sha256 "70ef314e31c5547f353ea7b2787faafa07adc32dcfaea6f4f1475512c23b0fc8"

  livecheck do
    url "https://eradman.com/ephemeralpg/code/"
    regex(/href=.*?ephemeralpg[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "c57037299f11da6b4560707c9380bfdbb8708f379bf8fccae6bf0069d4dedd8a"
    sha256 cellar: :any_skip_relocation, mojave:      "61a09eb4b62f4fd794ceb1af70f21198840598cd859a40c59c0be8799132ff86"
    sha256 cellar: :any_skip_relocation, high_sierra: "6889ddcf36023c982fe421ea8660445b416989968cc9a64b0a5156dd9f01cdfe"
  end

  depends_on "postgresql"

  def install
    system "make"
    system "make", "PREFIX=#{prefix}", "MANPREFIX=#{man}", "install"
  end

  test do
    return if ENV["CI"]

    system "#{bin}/pg_tmp", "selftest"
  end
end
