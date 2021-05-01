class CreateDmg < Formula
  desc "Shell script to build fancy DMGs"
  homepage "https://github.com/create-dmg/create-dmg"
  url "https://github.com/create-dmg/create-dmg/archive/v1.0.8.tar.gz"
  sha256 "6eb256e6835e650e4a529c9ea0630c409e6d1d5413fc9076b94d231674fa4cae"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "42ba5df600cee3cc0c2ea3da594e2c09b710e93345f36941bf11cbece30464be"
    sha256 cellar: :any_skip_relocation, mojave:      "42ba5df600cee3cc0c2ea3da594e2c09b710e93345f36941bf11cbece30464be"
    sha256 cellar: :any_skip_relocation, high_sierra: "42ba5df600cee3cc0c2ea3da594e2c09b710e93345f36941bf11cbece30464be"
  end

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    File.write(testpath/"Brew-Eula.txt", "Eula")
    (testpath/"Test-Source").mkpath
    (testpath/"Test-Source/Brew.app").mkpath
    system "#{bin}/create-dmg", "--sandbox-safe", "--eula",
           testpath/"Brew-Eula.txt", testpath/"Brew-Test.dmg", testpath/"Test-Source"
  end
end
