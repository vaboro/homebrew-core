class Draco < Formula
  desc "3D geometric mesh and point cloud compression library"
  homepage "https://google.github.io/draco/"
  url "https://github.com/google/draco/archive/1.3.6.tar.gz"
  sha256 "80eaa54ef5fc687c9aeebb9bd24d936d3e6d2c6048f358be8b83fa088ef4b2cb"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "54ea5852087b08f08945c7a73f6fc3b9d91958e6f23685c9848e08c2bce1ac03"
    sha256 cellar: :any_skip_relocation, mojave:      "cd40c18a7c54185a154785e7245ae1b3ddeff275a96854488e625f9a1b6701a5"
    sha256 cellar: :any_skip_relocation, high_sierra: "341560bdd2d7831f274feaa1646f10c79a00618d8c00f9522e885f23af1f2f87"
  end

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", * std_cmake_args
      system "make", "install"
    end
    pkgshare.install "testdata/cube_att.ply"
  end

  test do
    system "#{bin}/draco_encoder", "-i", "#{pkgshare}/cube_att.ply",
           "-o", "cube_att.drc"
    assert_predicate testpath/"cube_att.drc", :exist?
  end
end
