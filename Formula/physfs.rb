class Physfs < Formula
  desc "Library to provide abstract access to various archives"
  homepage "https://icculus.org/physfs/"
  url "https://icculus.org/physfs/downloads/physfs-3.0.2.tar.bz2"
  sha256 "304df76206d633df5360e738b138c94e82ccf086e50ba84f456d3f8432f9f863"
  head "https://hg.icculus.org/icculus/physfs/", using: :hg

  livecheck do
    url "https://icculus.org/physfs/downloads/"
    regex(/href=.*?physfs[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "31693a34c610ea382a1b0832065db2b223db549ced6fe6a2f8c569d6b58bf19a"
    sha256 cellar: :any, mojave:      "cb97a3a17728f3173d4c19fde495cffbddce965bbf6015e45882e3c27f267cf3"
    sha256 cellar: :any, high_sierra: "296927566472c976a578f89c4bd6bf0f518427a53d586499a8e202896d469ee3"
    sha256 cellar: :any, sierra:      "6742501c33943dcdab748b3c2188cf6292f462b82896da001cdbcfbbcc01e489"
  end

  depends_on "cmake" => :build

  uses_from_macos "zip" => :test

  on_linux do
    depends_on "readline"
  end

  def install
    mkdir "macbuild" do
      args = std_cmake_args
      args << "-DPHYSFS_BUILD_TEST=TRUE"
      args << "-DPHYSFS_BUILD_WX_TEST=FALSE" unless build.head?
      system "cmake", "..", *args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.txt").write "homebrew"
    system "zip", "test.zip", "test.txt"
    (testpath/"test").write <<~EOS
      addarchive test.zip 1
      cat test.txt
    EOS
    assert_match(/Successful\.\nhomebrew/, shell_output("#{bin}/test_physfs < test 2>&1"))
  end
end
