class Dcd < Formula
  desc "Auto-complete program for the D programming language"
  homepage "https://github.com/dlang-community/DCD"
  url "https://github.com/dlang-community/DCD.git",
      tag:      "v0.13.1",
      revision: "92db0486968f8ee59c16099c21b133dc4e9d91cb"
  license "GPL-3.0-or-later"
  head "https://github.com/dlang-community/dcd.git", shallow: false

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "cb5a1d6c16b9e7a63583f65ef8eea364291b847897e53c7bf2b5533f1965477b"
    sha256 cellar: :any_skip_relocation, mojave:      "13afc1eaa6e87e1a37eb80d9eef2febdc9a91b7cb7b68a4ba438a48c29e66776"
    sha256 cellar: :any_skip_relocation, high_sierra: "b72aa14601e382ab8ea67593dc0b365f7006a7d447291a8314af0bd47906e1ff"
  end

  depends_on "dmd" => :build

  def install
    system "make"
    bin.install "bin/dcd-client", "bin/dcd-server"
  end

  test do
    port = free_port

    # spawn a server, using a non-default port to avoid
    # clashes with pre-existing dcd-server instances
    server = fork do
      exec "#{bin}/dcd-server", "-p", port.to_s
    end
    # Give it generous time to load
    sleep 0.5
    # query the server from a client
    system "#{bin}/dcd-client", "-q", "-p", port.to_s
  ensure
    Process.kill "TERM", server
    Process.wait server
  end
end
