class Sourcery < Formula
  desc "Meta-programming for Swift, stop writing boilerplate code"
  homepage "https://github.com/krzysztofzablocki/Sourcery"
<<<<<<< HEAD
  url "https://github.com/krzysztofzablocki/Sourcery/archive/0.16.2.tar.gz"
  sha256 "a04ca9958d8a3d4570059cd71b3df1fda8db27027ef1340f28449a94f8e9ccc8"
=======
  url "https://github.com/krzysztofzablocki/Sourcery/archive/0.17.0.tar.gz"
  sha256 "f5a273cf1f6c5591e40505618b8914d8d536b3e345a681b974b58a92920d514d"
>>>>>>> upstream/master
  head "https://github.com/krzysztofzablocki/Sourcery.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "44f4fcd37b3694be58e5770446ebe08d7e39cf60dee8816a2aa362079dfad8dc" => :mojave
=======
    sha256 "e8b4ac7bc894f3889c6a8862b9b71344b51f4abaf08704f44a04a62ff95aabff" => :mojave
>>>>>>> upstream/master
  end

  depends_on :xcode => "10.2"

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "-Xswiftc", "-target", "-Xswiftc", "x86_64-apple-macosx10.11"
    bin.install ".build/release/sourcery"
    lib.install Dir[".build/release/*.dylib"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sourcery --version").chomp
  end
end
