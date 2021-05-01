class Lfe < Formula
  desc "Concurrent Lisp for the Erlang VM"
  homepage "https://lfe.io/"
  url "https://github.com/rvirding/lfe/archive/v1.3.tar.gz"
  sha256 "04634f2c700ecedb55f4369962837792669e6be809dba90d81974198fc2b7b72"
  license "Apache-2.0"
  head "https://github.com/rvirding/lfe.git", branch: "develop"

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, catalina:    "7dd076c48d565d4d0b686224178c1ee98a121529544633af3b13c71565f1f9e5"
    sha256 cellar: :any_skip_relocation, mojave:      "f05f9f0affc3bba078432f5822f85549ea905ce0dc4271f501e0d38e113dd09f"
    sha256 cellar: :any_skip_relocation, high_sierra: "4a2aff7e038f97050cbd8beb84023c9c9c093078ba4233ead520513bd708b3c5"
  end

  depends_on "emacs" if MacOS.version >= :catalina
  depends_on "erlang"

  def install
    system "make"
    system "make", "MANINSTDIR=#{man}", "install-man"
    system "make", "emacs"
    libexec.install "bin", "ebin"
    bin.install_symlink (libexec/"bin").children
    doc.install Dir["doc/*.txt"]
    pkgshare.install "dev", "examples", "test"
    elisp.install Dir["emacs/*.elc"]
  end

  test do
    system bin/"lfe", "-eval", '"(io:format \"~p\" (list (* 2 (lists:foldl #\'+/2 0 (lists:seq 1 6)))))"'
  end
end
