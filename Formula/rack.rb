class Rack < Formula
  desc "CLI for Rackspace"
  homepage "https://github.com/rackspace/rack"
  url "https://github.com/rackspace/rack.git",
      tag:      "1.2",
      revision: "09c14b061f4a115c8f1ff07ae6be96d9b11e08df"
  license "Apache-2.0"
  head "https://github.com/rackspace/rack.git"

  bottle do
    rebuild 2
    sha256 cellar: :any_skip_relocation, catalina:    "8cf224e3f734308bef6c0ef3cd9aa3a63aa4fdedd9ee626e2ee91099affc83c2"
    sha256 cellar: :any_skip_relocation, mojave:      "a50004c910fc4cbb34404fabf20bfcab87dcf6d7ce510a96c72fecbdc8d458cc"
    sha256 cellar: :any_skip_relocation, high_sierra: "5e33e2bc51e9cf346ed59eabbef5849a170619be2a7b034b19d71a1a25a72fcb"
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    ENV["TRAVIS_TAG"] = version

    rackpath = buildpath/"src/github.com/rackspace/rack"
    rackpath.install Dir["{*,.??*}"]

    cd rackpath do
      # This is a slightly grim hack to handle the weird logic around
      # deciding whether to add a = or not on the ldflags, as mandated
      # by Go 1.7+.
      # https://github.com/rackspace/rack/issues/446
      inreplace "script/build", "go1.5", Utils.safe_popen_read("go", "version")[/go1\.\d/]

      ln_s "internal", "vendor"
      system "script/build", "rack"
      bin.install "rack"
      prefix.install_metafiles
    end
  end

  test do
    system "#{bin}/rack"
  end
end
