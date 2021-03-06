class JpegArchive < Formula
  desc "Utilities for archiving JPEGs for long term storage"
  homepage "https://github.com/danielgtaylor/jpeg-archive"
  url "https://github.com/danielgtaylor/jpeg-archive/archive/v2.2.0.tar.gz"
  sha256 "3da16a5abbddd925dee0379aa51d9fe0cba33da0b5703be27c13a2dda3d7ed75"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "a48ad5ec6802a9a1ba2e689b49c2dd4f6e8edd98950c3e3104ff495953d32e34"
    sha256 cellar: :any_skip_relocation, mojave:      "1fe424d0224c4d76e83aadcdbdbe7b2a4e63873651049ee13c66bc8c55fa916c"
    sha256 cellar: :any_skip_relocation, high_sierra: "2bb41fa08a695f6552524c21bd5e32434f248f8e41bd11574ce8a9d4cf104ea1"
    sha256 cellar: :any_skip_relocation, sierra:      "fe29c7341dffa1ac8d52635ca217e5808c25a98c74748d71c389d951a46fe1cd"
    sha256 cellar: :any_skip_relocation, el_capitan:  "0f70f902c57261d92bcb9c8602d46b939ca8f7a55bb535cce67324ae3f3920c7"
  end

  depends_on "mozjpeg"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/jpeg-recompress", test_fixtures("test.jpg"), "output.jpg"
  end
end
