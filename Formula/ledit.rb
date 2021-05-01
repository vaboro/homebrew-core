class Ledit < Formula
  desc "Line editor for interactive commands"
  homepage "http://pauillac.inria.fr/~ddr/ledit/"
  url "http://pauillac.inria.fr/~ddr/ledit/distrib/src/ledit-2.04.tgz"
  sha256 "484897016b001b6d64eb24e38a213177b230ebf8e0d9808a969b62f012e70ee4"

  livecheck do
    url :homepage
    regex(/current .*? is v?(\d+(?:\.\d+)+) /i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "084768158bc35e6f6eb496d0adea9253cbbb18738c8ef03318a079fef179fc80"
    sha256 cellar: :any_skip_relocation, mojave:      "10b506580124bb9ac062675ae72d70d95b73ee67483d6968b8628b7a01cd6653"
    sha256 cellar: :any_skip_relocation, high_sierra: "55df7d80dfcfb5c04274f9a33a5fc03a4a1b9b2b1fb4f3b08c0cef83759c74a3"
    sha256 cellar: :any_skip_relocation, sierra:      "b7e2b19079d843f9704572bf21de6251e7a6619d809ce230e22be5440517ab57"
    sha256 cellar: :any_skip_relocation, el_capitan:  "952162580a2542b7038b2702b8a2ed9223e519ca703b221daf054566723ecd59"
  end

  depends_on "camlp5"
  depends_on "ocaml"

  def install
    # like camlp5, this build fails if the jobs are parallelized
    ENV.deparallelize
    args = %W[BINDIR=#{bin} LIBDIR=#{lib} MANDIR=#{man}]
    system "make", *args
    system "make", "install", *args
  end

  test do
    history = testpath/"history"
    pipe_output("#{bin}/ledit -x -h #{history} bash", "exit\n", 0)
    assert_predicate history, :exist?
    assert_equal "exit\n", history.read
  end
end
