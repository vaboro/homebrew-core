class Jsvc < Formula
  desc "Wrapper to launch Java applications as daemons"
  homepage "https://commons.apache.org/daemon/jsvc.html"
  url "https://www.apache.org/dyn/closer.lua?path=commons/daemon/source/commons-daemon-1.2.3-src.tar.gz"
  mirror "https://archive.apache.org/dist/commons/daemon/source/commons-daemon-1.2.3-src.tar.gz"
  sha256 "37b8c461c52e76c1ed6cd290431237611dfe496df36cd70e5afa30659d9bce4c"
  license "Apache-2.0"

  livecheck do
    url :stable
  end

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "43ff51b167da0ae5d591aa071b5901004bc5697ebc68347837008fa8f199e8ae"
    sha256 cellar: :any_skip_relocation, mojave:      "edbe820236ac1a74c9a285720771e3e7475fdfa0c341e1b708865d84a5434a39"
    sha256 cellar: :any_skip_relocation, high_sierra: "78a38df683b1a1d51394559ad9df64d72e9f276ce896dd3f5815034f8f435907"
  end

  depends_on "openjdk"

  def install
    prefix.install %w[NOTICE.txt LICENSE.txt RELEASE-NOTES.txt]

    cd "src/native/unix" do
      system "./configure", "--with-java=#{Formula["openjdk"].opt_prefix}"
      system "make"

      libexec.install "jsvc"
      (bin/"jsvc").write_env_script libexec/"jsvc", Language::Java.overridable_java_home_env
    end
  end

  test do
    output = shell_output("#{bin}/jsvc -help")
    assert_match "jsvc (Apache Commons Daemon)", output
  end
end
