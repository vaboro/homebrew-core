class MsgpackTools < Formula
  desc "Command-line tools for converting between MessagePack and JSON"
  homepage "https://github.com/ludocode/msgpack-tools"
  url "https://github.com/ludocode/msgpack-tools/releases/download/v0.6/msgpack-tools-0.6.tar.gz"
  sha256 "98c8b789dced626b5b48261b047e2124d256e5b5d4fbbabdafe533c0bd712834"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "901f0f7dadb40b70b20de05a699e5cd9ca37095f3ce9bb277aff3e4421219290"
    sha256 cellar: :any_skip_relocation, mojave:      "30f69cfbcfe93c148fec339d86775357cc804f50c58c42594708f7ae9abad226"
    sha256 cellar: :any_skip_relocation, high_sierra: "9c12c496640b2913caa23147bdacffed803115e68607c56975bdab106b4b83b0"
    sha256 cellar: :any_skip_relocation, sierra:      "c576acc7e6078360a79bf7270336e0f3dc9012161e860681cbfe7f2de1313857"
  end

  depends_on "cmake" => :build

  conflicts_with "remarshal", because: "both install 'json2msgpack' binary"

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install", "PREFIX=#{prefix}/"
  end

  test do
    json_data = '{"hello":"world"}'
    assert_equal json_data,
      pipe_output("#{bin}/json2msgpack | #{bin}/msgpack2json", json_data, 0)
  end
end
