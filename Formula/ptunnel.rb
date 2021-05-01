class Ptunnel < Formula
  desc "Tunnel over ICMP"
  homepage "https://www.cs.uit.no/~daniels/PingTunnel/"
  url "https://www.cs.uit.no/~daniels/PingTunnel/PingTunnel-0.72.tar.gz"
  sha256 "b318f7aa7d88918b6269d054a7e26f04f97d8870f47bd49a76cb2c99c73407a4"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:    "15d1785092ce8788e96232fc051be9311aaa6565c6a65dfbb96d0ec597970384"
    sha256 cellar: :any_skip_relocation, mojave:      "3c8f8ec4d66e42ad4a6513a4c92e0f3e0babfebe25fb08ff4c690b1a37557fdd"
    sha256 cellar: :any_skip_relocation, high_sierra: "67bd833b70dc704ab565d526fd99044e122a4e2fcd583b083db0a5f642d46041"
    sha256 cellar: :any_skip_relocation, sierra:      "048404c7b3fe3365abfc24fb623bf9548ed7e61458a00148348bbdc2f5f12f33"
    sha256 cellar: :any_skip_relocation, el_capitan:  "516181dbd16539c1f8817d65637bd42cc951d551e1a3b61a4d83dc6c71dc6397"
    sha256 cellar: :any_skip_relocation, yosemite:    "72db3faba8fbd7c268acf22d02ae0df4dbb5dde2db8a17ca4d62b2293d0763e0"
    sha256 cellar: :any_skip_relocation, mavericks:   "a39ae93cf1d20d9a24cf194d8b1fde7166b64276056cb084824d4291bd3f8faf"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  def caveats
    <<~EOS
      Normally, ptunnel uses raw sockets and must be run as root (using sudo, for example).

      Alternatively, you can try using the -u flag to start ptunnel in 'unprivileged' mode,
      but this is not recommended. See https://www.cs.uit.no/~daniels/PingTunnel/ for details.
    EOS
  end

  test do
    assert_match "v #{version}", shell_output("#{bin}/ptunnel -h", 1)
  end
end
