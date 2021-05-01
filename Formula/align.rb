class Align < Formula
  desc "Text column alignment filter"
  homepage "https://www.cs.indiana.edu/~kinzler/align/"
  url "https://www.cs.indiana.edu/~kinzler/align/align-1.7.5.tgz"
  sha256 "cc692fb9dee0cc288757e708fc1a3b6b56ca1210ca181053a371cb11746969dd"
  license "GPL-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "cca0be9634d92fe10b845b98f26ee953f59482e0436806484a907f487e76d093"
    sha256 cellar: :any_skip_relocation, mojave:      "b8de67536085ba47ddeaed3b8567645beaf5e84ab0b7ab958cf7b6cc358e10dc"
    sha256 cellar: :any_skip_relocation, high_sierra: "4b0b70a5909b7d6d2fa78fcb4e36acb20295202adbdbd6bf5754530f7e055199"
    sha256 cellar: :any_skip_relocation, sierra:      "4d07f4f2ae948de293afdc80a5a736cf81da7c335cec1778f5b7304debda6599"
    sha256 cellar: :any_skip_relocation, el_capitan:  "c2c177c8be3b5a58e60f3a1f39d9fdd3cc3d39247d92be45142cd06ae80273bf"
    sha256 cellar: :any_skip_relocation, yosemite:    "caa9e8c3b3a9d946b95d5222b1518c5307499d57fe17f593ec3911f9cc6eace7"
    sha256 cellar: :any_skip_relocation, mavericks:   "f903cb30e079f56c5743e2ca22a168c61d7a7c57b2cf6bc3c6492ed214a296a3"
  end

  conflicts_with "speech-tools", because: "both install `align` binaries"

  def install
    system "make", "install", "BINDIR=#{bin}"
  end

  test do
    assert_equal " 1  1\n12 12\n", pipe_output(bin/"align", "1 1\n12 12\n")
  end
end
