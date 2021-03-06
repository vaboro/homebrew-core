class Sccache < Formula
  desc "Used as a compiler wrapper and avoids compilation when possible"
  homepage "https://github.com/mozilla/sccache"
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://github.com/mozilla/sccache/archive/0.2.10.tar.gz"
  sha256 "e55813d2ca01ebf5704973bb5765a6b3bdf2d6f563be34441a278599579bb5e0"
<<<<<<< HEAD
=======
  revision 1
>>>>>>> upstream/master
=======
  url "https://github.com/mozilla/sccache/archive/0.2.11.tar.gz"
  sha256 "d72569789c4c54e5c8dc20bbde8e553b85497dbd9a3fdcc6d738a4df411dea46"
>>>>>>> upstream/master
=======
  url "https://github.com/mozilla/sccache/archive/0.2.13.tar.gz"
  sha256 "81c973cf9a89e77f02a6b5710298531ba2e50d2555e8a931e505fbf570522e2a"
  license "Apache-2.0"
>>>>>>> upstream/master
  head "https://github.com/mozilla/sccache.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    sha256 "31bdf1b96a50e026c7ba90e29f5db9a14d1525ed418326fa9630e541e26940a7" => :mojave
    sha256 "6ef70150d5639a61368df3b2a4a166a038cd26fe3194ffaeb335d5f995085fa8" => :high_sierra
    sha256 "a9caa5681b47b7adfd7e50e7754781b3e8a3eb7879b479dbf4c192c16d0b31e6" => :sierra
=======
    sha256 "6c621b61c1ba1bfe016cb667b6393767563ae2c7cf56d9d69948193b8cb19809" => :mojave
    sha256 "23a85c09ccc988d05bfe83f69a7cd9c6f2936281641266ffde00efd4b700ad72" => :high_sierra
    sha256 "fc9d87826b46f183a010e98e954d2abc7b72d1211ef4cc947040bd82a23df50b" => :sierra
>>>>>>> upstream/master
=======
    sha256 "915be21657f33db3e030830e98a80cbc11b45d8777489774353274069825ff51" => :mojave
    sha256 "1b0ba25e94540261cb3c2b4e51fd6e7bc4c5504ec7731ada2cb391b5c6d56159" => :high_sierra
    sha256 "b478e2417a9aa5be0ff5c90de91ee4e810bca29966dca0d3e5b28a06dc6f182f" => :sierra
>>>>>>> upstream/master
=======
    sha256 "a4e38444e682b90e9cea144347e5f1fc32ab309ba448d495b025bb9bb19906d4" => :catalina
    sha256 "80f2b3cfa57125f7fd927b8b312483ca91c146dd76702d1a2e0cefdac5ae25f5" => :mojave
    sha256 "071e45205799343d3f2be7c3779292cbcf32d1bfa1861f70af55e9cca50fe891" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "rust" => :build
  depends_on "openssl@1.1"

  def install
    # Ensure that the `openssl` crate picks up the intended library.
    # https://crates.io/crates/openssl#manual-configuration
    ENV["OPENSSL_DIR"] = Formula["openssl@1.1"].opt_prefix

    system "cargo", "install", "--features", "all", *std_cargo_args
  end

  test do
    (testpath/"hello.c").write <<~EOS
      #include <stdio.h>
      int main() {
        puts("Hello, world!");
        return 0;
      }
    EOS
    system "#{bin}/sccache", "cc", "hello.c", "-o", "hello-c"
    assert_equal "Hello, world!", shell_output("./hello-c").chomp
  end
end
