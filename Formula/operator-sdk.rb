class OperatorSdk < Formula
  desc "SDK for building Kubernetes applications"
  homepage "https://coreos.com/operators/"
  url "https://github.com/operator-framework/operator-sdk.git",
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
  end

  depends_on "go"

  def install
    # TODO: Do not set GOROOT. This is a fix for failing tests when compiled with Go 1.13.
    # See https://github.com/Homebrew/homebrew-core/pull/43820.
    ENV["GOROOT"] = Formula["go"].opt_libexec

    ENV["GOPATH"] = buildpath
    ENV["GO111MODULE"] = "on"

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
  end

  test do
    # Use go modules when generating an operator
    ENV["GO111MODULE"] = "on"

    # Use the offical golang module cache to prevent network flakes and allow
    # this test to complete before timing out.
    ENV["GOPROXY"] = "https://proxy.golang.org"

    if build.stable?
      version_output = shell_output("#{bin}/operator-sdk version")
      assert_match "version: v#{version}", version_output
      assert_match stable.specs[:revision], version_output
    end

    # Create a new, blank operator
    system "#{bin}/operator-sdk", "new", "test", "--repo=github.com/example-inc/app-operator"

    cd "test" do
      # Add an example API resource. This exercises most of the various pieces
      # of generation logic.
      system "#{bin}/operator-sdk", "add", "api", "--api-version=app.example.com/v1alpha1", "--kind=AppService"
    end
  end
end
