class Fstrm < Formula
  desc "Frame Streams implementation in C"
  homepage "https://github.com/farsightsec/fstrm"
  url "https://dl.farsightsecurity.com/dist/fstrm/fstrm-0.6.0.tar.gz"
  sha256 "a7049089eb0861ecaa21150a05613caa6dee4e8545b91191eff2269caa923910"
  license "MIT"

  bottle do
    sha256 cellar: :any, catalina:    "e84d0b8f2c27683c16e0d168a94b355cc2dcdfae2b118b943b3853579f85a829"
    sha256 cellar: :any, mojave:      "d20520e5164f271d97214c4645186996ee926c3847d59e8236e6dd643edec13b"
    sha256 cellar: :any, high_sierra: "8a373443cef458c2384efa537867eba87a19f58a413f052dcf0ee4c6636a379b"
  end

  head do
    url "https://github.com/farsightsec/fstrm.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libevent"

  def install
    system "autoreconf", "-fvi" if build.head?
    system "./configure", "--disable-debug",
           "--disable-dependency-tracking",
           "--disable-silent-rules",
           "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    job = fork do
      exec bin/"fstrm_capture", "-t", "protobuf:dnstap.Dnstap",
           "-u", "dnstap.sock", "-w", "capture.fstrm", "-dddd"
    end
    sleep 2
    Process.kill("TERM", job)
    system "#{bin}/fstrm_dump", "capture.fstrm"
  end
end
