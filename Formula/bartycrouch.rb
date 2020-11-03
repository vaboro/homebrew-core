class Bartycrouch < Formula
  desc "Incrementally update/translate your Strings files"
  homepage "https://github.com/Flinesoft/BartyCrouch"
  url "https://github.com/Flinesoft/BartyCrouch.git",
      tag:      "4.2.0",
      revision: "49b4cf27d5b521abf615d4ccb7754d642205f802"
  license "MIT"
  head "https://github.com/Flinesoft/BartyCrouch.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "86f4e9f2e99b0e6c34756e73365228833f3ea39251cb082eff4f37b7a38dc42e" => :catalina
  end

  depends_on xcode: ["11.4", :build]

  def install
    system "make", "install", "prefix=#{prefix}"
  end

  test do
    (testpath/"Test.swift").write <<~EOS
      import Foundation

      class Test {
        func test() {
            NSLocalizedString("test", comment: "")
        }
      }
    EOS

    (testpath/"en.lproj/Localizable.strings").write <<~EOS
      /* No comment provided by engineer. */
      "oldKey" = "Some translation";
    EOS

    system bin/"bartycrouch", "update"
    assert_match /"oldKey" = "/, File.read("en.lproj/Localizable.strings")
    assert_match /"test" = "/, File.read("en.lproj/Localizable.strings")
  end
end
