class Sourcery < Formula
  desc "Meta-programming for Swift, stop writing boilerplate code"
  homepage "https://github.com/krzysztofzablocki/Sourcery"
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://github.com/krzysztofzablocki/Sourcery/archive/0.16.2.tar.gz"
  sha256 "a04ca9958d8a3d4570059cd71b3df1fda8db27027ef1340f28449a94f8e9ccc8"
=======
  url "https://github.com/krzysztofzablocki/Sourcery/archive/0.17.0.tar.gz"
  sha256 "f5a273cf1f6c5591e40505618b8914d8d536b3e345a681b974b58a92920d514d"
>>>>>>> upstream/master
=======
  url "https://github.com/krzysztofzablocki/Sourcery/archive/1.0.0.tar.gz"
  sha256 "5947267143fc63504bb21c094accad8c51160834f204a9b108211f28525bfbe4"
  license "MIT"
>>>>>>> upstream/master
  head "https://github.com/krzysztofzablocki/Sourcery.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
<<<<<<< HEAD
    sha256 "44f4fcd37b3694be58e5770446ebe08d7e39cf60dee8816a2aa362079dfad8dc" => :mojave
=======
    sha256 "e8b4ac7bc894f3889c6a8862b9b71344b51f4abaf08704f44a04a62ff95aabff" => :mojave
>>>>>>> upstream/master
=======
    sha256 "18df6fc42860b714ce6f2e31e0c2df6409927d793d4c5594b3e752feae42d6a7" => :catalina
    sha256 "adbafe637b3ffb78250e1ad95514d1c9fe597331fe13e89925381783803bf255" => :mojave
>>>>>>> upstream/master
  end

  depends_on xcode: "10.2"

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "-Xswiftc",
                             "-target", "-Xswiftc", "x86_64-apple-macosx10.11"
    bin.install ".build/release/sourcery"
    lib.install Dir[".build/release/*.dylib"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sourcery --version").chomp
  end
end
