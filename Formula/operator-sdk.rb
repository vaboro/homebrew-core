class OperatorSdk < Formula
  desc "SDK for building Kubernetes applications"
  homepage "https://coreos.com/operators/"
  url "https://github.com/operator-framework/operator-sdk.git",
<<<<<<< HEAD
      :tag      => "v0.10.0",
      :revision => "ff80b17737a6a0aade663e4827e8af3ab5a21170"
<<<<<<< HEAD
  head "https://github.com/operator-framework/operator-sdk.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4dd029800a64eab9ea04f49f60da816982cd3087ab47cb70e18e103c4f1390de" => :mojave
    sha256 "adef1143400f267b08bb7b470f48cc4be8afdb8d6a25bbf85d65a4e4aa8c1038" => :high_sierra
    sha256 "1f60ddd6915551a9c7dbad82402be2d05469544c14776662301eedaa71e4c4b1" => :sierra
=======
  revision 1
  head "https://github.com/operator-framework/operator-sdk.git"

  bottle do
    rebuild 1
    sha256 "367dd7a981cb77114e40b25bfb413c862b9931cf90bf5cbccdad60cc32165eae" => :mojave
    sha256 "91a932437b54fbc5e8730a84a21c2cc865e6ad81c23cd25f5b3a592aaf1a1976" => :high_sierra
    sha256 "60b8a7947caf489ce3429d87991905fc781b67fa5b552bd8b662abefdbe2bde4" => :sierra
>>>>>>> upstream/master
=======
      tag:      "v1.0.0",
      revision: "d7d5e0cd6cf5468bb66e0849f08fda5bf557f4fa"
  license "Apache-2.0"
  head "https://github.com/operator-framework/operator-sdk.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "12a2f74aefa1080a6f5398a34a6fa3e5dbc073701d417f3c98b223004947f4b4" => :catalina
    sha256 "407b855e436cedc91a6be8c4e2280928a7267c0e468db1183919d11588b29b62" => :mojave
    sha256 "ec30eef2b5107b09652baee76189b8f9eff0d4d4be7f940e740b7baad521e68a" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "go"

  def install
    ENV["GOBIN"] = bin
    system "make", "install"

    # Install bash completion
    output = Utils.safe_popen_read("#{bin}/operator-sdk", "completion", "bash")
    (bash_completion/"operator-sdk").write output

<<<<<<< HEAD
    dir = buildpath/"src/github.com/operator-framework/operator-sdk"
    dir.install buildpath.children - [buildpath/".brew_home"]
    dir.cd do
      # Make binary
<<<<<<< HEAD
      system "make", "build/operator-sdk-#{stable.specs[:tag]}-x86_64-apple-darwin"
      bin.install "build/operator-sdk-v0.10.0-x86_64-apple-darwin" => "operator-sdk"
=======
      system "make", "install"
      bin.install buildpath/"bin/operator-sdk"
>>>>>>> upstream/master

      # Install bash completion
      output = Utils.popen_read("#{bin}/operator-sdk completion bash")
      (bash_completion/"operator-sdk").write output

      # Install zsh completion
      output = Utils.popen_read("#{bin}/operator-sdk completion zsh")
      (zsh_completion/"_operator-sdk").write output

      prefix.install_metafiles
    end
=======
    # Install zsh completion
    output = Utils.safe_popen_read("#{bin}/operator-sdk", "completion", "zsh")
    (zsh_completion/"_operator-sdk").write output
>>>>>>> upstream/master
  end

  test do
    if build.stable?
      version_output = shell_output("#{bin}/operator-sdk version")
      assert_match "version: \"v#{version}\"", version_output
      assert_match stable.specs[:revision], version_output
    end

    system bin/"operator-sdk", "init", "--domain=example.com", "--repo=example.com/example/example"
    assert_predicate testpath/"bin/manager", :exist?
  end
end
