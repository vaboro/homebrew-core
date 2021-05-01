class IosDeploy < Formula
  desc "Install and debug iPhone apps from the command-line"
  homepage "https://github.com/ios-control/ios-deploy"
  url "https://github.com/ios-control/ios-deploy/archive/1.11.1.tar.gz"
  sha256 "638c90ae7ec71bc89ed0f2e9a464b9db8f2b312a20802c782873f82675d41048"
  license all_of: ["GPL-3.0-or-later", "BSD-3-Clause"]
  head "https://github.com/ios-control/ios-deploy.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "af5fd607db481534ebb05a85a781ef562d18095ad281dcb43739b7cdd9f0645a"
    sha256 cellar: :any_skip_relocation, mojave:      "c496d357fcf45cb2dbb7b281c588b6b36e72e5f0a2126dca7bf7b311acec26c3"
    sha256 cellar: :any_skip_relocation, high_sierra: "fc27814ad907fcfecaada65a07128eb8fdf4eaaf9e90cf07f2aa483e8fee2a89"
  end

  depends_on xcode: :build

  def install
    xcodebuild "-configuration", "Release", "SYMROOT=build"

    xcodebuild "test", "-scheme", "ios-deploy-tests", "-configuration", "Release", "SYMROOT=build"

    bin.install "build/Release/ios-deploy"
  end

  test do
    system "#{bin}/ios-deploy", "-V"
  end
end
