class Ski < Formula
  desc "Evade the deadly Yeti on your jet-powered skis"
  homepage "http://catb.org/~esr/ski/"
  url "http://www.catb.org/~esr/ski/ski-6.13.tar.gz"
  sha256 "34e95547ecfe7b3791df0a81fef9af422ececf49b1aa1e93bbb1ba067ccdc955"
  license "BSD-2-Clause"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "b647b2162475b1dccee3afe7d6d878108fc3ac97826756c355b0c8b748143253"
    sha256 cellar: :any_skip_relocation, mojave:      "b647b2162475b1dccee3afe7d6d878108fc3ac97826756c355b0c8b748143253"
    sha256 cellar: :any_skip_relocation, high_sierra: "b647b2162475b1dccee3afe7d6d878108fc3ac97826756c355b0c8b748143253"
  end

  head do
    url "https://gitlab.com/esr/ski.git"
    depends_on "xmlto" => :build
  end

  def install
    if build.head?
      ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"
      system "make"
    end
    bin.install "ski"
    man6.install "ski.6"
  end

  test do
    assert_match "Bye!", pipe_output("#{bin}/ski", "")
  end
end
