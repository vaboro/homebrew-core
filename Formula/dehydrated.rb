class Dehydrated < Formula
  desc "LetsEncrypt/acme client implemented as a shell-script"
  homepage "https://dehydrated.io"
  url "https://github.com/lukas2511/dehydrated/archive/v0.6.5.tar.gz"
  sha256 "10aabd0027450bc70a18e49acaca7a9697e0cfb92368d3e508b7a4d6d69bfa35"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "844e6e0618f99e44fb74c86abfed902f82e6c67ac9879f41a1f1bd0922554730"
    sha256 cellar: :any_skip_relocation, mojave:      "376b14fa1047117a1779c583cd73139b7e4e8d3dafae240bac62912580aae571"
    sha256 cellar: :any_skip_relocation, high_sierra: "376b14fa1047117a1779c583cd73139b7e4e8d3dafae240bac62912580aae571"
    sha256 cellar: :any_skip_relocation, sierra:      "1b4042e46b66cb78a1f4a423d742bfe3110f12ea8d26177ff0f05d2aea24d6b2"
  end

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/lukas2511/dehydrated").install buildpath.children
    cd "src/github.com/lukas2511/dehydrated" do
      bin.install "dehydrated"
      prefix.install_metafiles
    end
  end

  test do
    system bin/"dehydrated", "--help"
  end
end
