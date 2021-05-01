class Yaegi < Formula
  desc "Yet another elegant Go interpreter"
  homepage "https://github.com/containous/yaegi"
  url "https://github.com/containous/yaegi/archive/v0.9.0.tar.gz"
  sha256 "2ab747b4b9187fec4922492c2ada936a64b71e1a2cb6d01c6b6a1db61ade2399"
  license "Apache-2.0"
  head "https://github.com/containous/yaegi.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "709800220736bd8569a3b4522cb40cbf5902e076be932b3fe2e656572b070435"
    sha256 cellar: :any_skip_relocation, mojave:      "e65df0b95cd19be6fd6fb7731ee8e78a3d31b1898f8f2344287ddd5bf6305ef4"
    sha256 cellar: :any_skip_relocation, high_sierra: "f92a7e36b0aea6837632b3a098248fdfe17b794cd71a19c48e0afb1919ccc9c7"
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "./cmd/yaegi"
  end

  test do
    assert_match "4", pipe_output("#{bin}/yaegi", "println(3 + 1)", 0)
  end
end
