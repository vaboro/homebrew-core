class Rem < Formula
  desc "Command-line tool to access OSX Reminders.app database"
  homepage "https://github.com/kykim/rem"
  url "https://github.com/kykim/rem/archive/20150618.tar.gz"
  sha256 "e57173a26d2071692d72f3374e36444ad0b294c1284e3b28706ff3dbe38ce8af"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "bfab3fd2fd8da4e4620d80a632d774b4742c6c34c5b73d89fafd3d246369fce6"
    sha256 cellar: :any_skip_relocation, mojave:      "4226be6dc999a4467a061055cb36a68babe84a835f40f32a5a23f6137ddd59b4"
    sha256 cellar: :any_skip_relocation, high_sierra: "0a3365c8653023f2b4de8c5b6243aec2de7c180d1be982adcdbe58afc159800e"
    sha256 cellar: :any_skip_relocation, sierra:      "326f7a21f696b7614a55a5edeb57e08482ff7b4c72506bcecff5deaa0552828e"
    sha256 cellar: :any_skip_relocation, el_capitan:  "c9892df4f6aa5d58097e4cc4d62388ccbb1e0c02604b1139cfe829d47d992442"
    sha256 cellar: :any_skip_relocation, yosemite:    "d9a6303ff3935923ba53d093e95387caaf24460a4cd7fb7d330fa5c3988b551c"
    sha256 cellar: :any_skip_relocation, mavericks:   "bf65e89ec4ca486b95f04c1c737627b2e0091af8a5c137795e521b96664d75e2"
  end

  depends_on xcode: :build

  conflicts_with "remind", because: "both install `rem` binaries"

  def install
    xcodebuild "SYMROOT=build"
    bin.install "build/Release/rem"
  end

  test do
    system "#{bin}/rem", "version"
  end
end
