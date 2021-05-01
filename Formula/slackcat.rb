class Slackcat < Formula
  desc "Command-line utility for posting snippets to Slack"
  homepage "https://github.com/vektorlab/slackcat"
  url "https://github.com/vektorlab/slackcat/archive/v1.6.tar.gz"
  sha256 "e5c8f98f3048cccc3f8e49c0449435a839a18c7f12426643ac80731b63b829a9"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "31ab32e1c07a54dd6e06900a990f2e4b82295273155f25332596c17671d33b9f"
    sha256 cellar: :any_skip_relocation, mojave:      "b8fb7acbcb922af01da7e97b7c3ef303dcda92762996d2ad9a12ffec1bfea608"
    sha256 cellar: :any_skip_relocation, high_sierra: "4a5566659aedb0453c68c468c65521b53d0602113a940b50afab759488b4997c"
    sha256 cellar: :any_skip_relocation, sierra:      "80ed662db0f0e057a2346e25244b52fd3019fdb6f1af1e809b03392a82d0dcd9"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath

    src = buildpath/"src/github.com/vektorlab/slackcat"
    src.install buildpath.children
    src.cd do
      system "go", "build", "-o", bin/"slackcat", "-ldflags", "-X main.version=#{version}"
      prefix.install_metafiles
    end
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/slackcat -v")
  end
end
