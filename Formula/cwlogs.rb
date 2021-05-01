class Cwlogs < Formula
  desc "CLI tool for reading logs from Cloudwatch Logs"
  homepage "https://github.com/segmentio/cwlogs"
  url "https://github.com/segmentio/cwlogs/archive/v1.2.0.tar.gz"
  sha256 "3f7b56b49c42c1de0e697fc391abad07b03434cff36b153249dd2af3107e064e"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "b28a57d8b6d5801ccbbbb9227952f9bd67935a62a0ddcaefddec2650a5296eba"
    sha256 cellar: :any_skip_relocation, mojave:      "094c93934776870df7b417ea5099a604fd8312e1bfa67f27628fa73f2c5dc388"
    sha256 cellar: :any_skip_relocation, high_sierra: "1c07bb31b455ea7e28f55854424b9fbcba9f9ab9e352f759377d7152b1b3c367"
    sha256 cellar: :any_skip_relocation, sierra:      "b3528646611cd4f462bafe83c25c84f551e191629a93a84b11c872f9e86b720f"
    sha256 cellar: :any_skip_relocation, el_capitan:  "6384495666e5235c5969ccd1688092fe335a5147b31156e1cb658a41594ae594"
  end

  depends_on "go" => :build
  depends_on "govendor" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["GOOS"] = "darwin"
    ENV["GOARCH"] = "amd64"
    ENV["CGO_ENABLED"] = "0"

    path = buildpath/"src/github.com/segmentio/cwlogs"
    path.install Dir["{*,.git}"]

    cd "src/github.com/segmentio/cwlogs" do
      system "govendor", "sync"
      system "go", "build", "-o", bin/"cwlogs",
                   "-ldflags", "-X main.Version=#{version}"
      prefix.install_metafiles
    end
  end

  test do
    output = shell_output("#{bin}/cwlogs help")
    assert_match "cloudwatch logs", output
  end
end
