class Texlab < Formula
  desc "Implementation of the Language Server Protocol for LaTeX"
  homepage "https://texlab.netlify.com/"
  url "https://github.com/latex-lsp/texlab/archive/v2.2.0.tar.gz"
  sha256 "313b7c230c71a0087a2a5aadbba1d8ba1a929e1e8f98b8b7553ca956fc567835"
  license "GPL-3.0"
  head "https://github.com/latex-lsp/texlab.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "27c48990087cf5e0c83ed2f18e2312026214e25ff0948d1b440486029ead5433" => :catalina
    sha256 "e0c354c84d065702a8683cce427f8311e1b264792f9295da496098db7182d350" => :mojave
    sha256 "e94b88352e4e10f186f4b3f475b3af70674afb92d2bb78259a59d872bcbf218b" => :high_sierra
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    require "open3"

    begin
      stdin, stdout, _, wait_thr = Open3.popen3("#{bin}/texlab")
      pid = wait_thr.pid
      stdin.write <<~EOF
        Content-Length: 103

        {"jsonrpc": "2.0", "id": 0, "method": "initialize", "params": { "rootUri": null, "capabilities": {}}}

      EOF
      assert_match "Content-Length:", stdout.gets("\n")
    ensure
      Process.kill "SIGKILL", pid
    end
  end
end
