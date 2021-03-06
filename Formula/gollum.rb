class Gollum < Formula
  desc "Go n:m message multiplexer"
  homepage "https://github.com/trivago/gollum"
  url "https://github.com/trivago/gollum/archive/v0.5.4.tar.gz"
  sha256 "ba2299c7946385704b7952a77f28e6a7bd243f350e31e7009e21586ec9ca5494"
  license "Apache-2.0"
  head "https://github.com/trivago/gollum.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "bf987d3c10c67153ffc11b1926162882d00cdf23261516e614181dafb67eb70c"
    sha256 cellar: :any_skip_relocation, mojave:      "d2d022b779e4290e98d0783232b00c79bf46fc08d9ad3bea0dd352071e2995f3"
    sha256 cellar: :any_skip_relocation, high_sierra: "afaf112d706150eeb5f8e5152a7b88ef18fc944fdd01dc8a46357a3c8ce13f8b"
    sha256 cellar: :any_skip_relocation, sierra:      "9e82aadccabe2a1224658cc824536e061d617355bb7f7eda5a889e117c3bb472"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/trivago/gollum").install buildpath.children
    cd "src/github.com/trivago/gollum" do
      system "go", "build", "-o", bin/"gollum"
      prefix.install_metafiles
    end
  end

  test do
    (testpath/"test.conf").write <<~EOS
      "Profiler":
          Type: "consumer.Profiler"
          Runs: 100000
          Batches: 100
          Characters: "abcdefghijklmnopqrstuvwxyz .,!;:-_"
          Message: "%256s"
          Streams: "profile"
          KeepRunning: false
          ModulatorRoutines: 0

      "Benchmark":
          Type: "producer.Benchmark"
          Streams: "profile"
    EOS
    assert_match "Config OK.", shell_output("#{bin}/gollum -tc #{testpath}/test.conf")
  end
end
