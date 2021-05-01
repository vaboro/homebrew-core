class Ppsspp < Formula
  desc "PlayStation Portable emulator"
  homepage "https://ppsspp.org/"
  url "https://github.com/hrydgard/ppsspp.git",
      tag:      "v1.10.3",
      revision: "087de849bdc74205dd00d8e6e11ba17a591213ab"
  license all_of: ["GPL-2.0-or-later", "BSD-3-Clause"]
  head "https://github.com/hrydgard/ppsspp.git"

  bottle do
    sha256 cellar: :any, catalina:    "1c79cc6ca4e1add2d0241309d597a7d438cb9c3f1ea67acb39682e1b5614e8ce"
    sha256 cellar: :any, mojave:      "8acc30ceaa93a21f13dd3e21756ab08fee494537a7ea0e0e94cd6421691e28bd"
    sha256 cellar: :any, high_sierra: "e9d362ed61fcc7bfbaa23db4ea427e00ea89cfa931c11133782ae4497bccca9a"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "ffmpeg"
  depends_on "glew"
  depends_on "libzip"
  depends_on "sdl2"
  depends_on "snappy"

  def install
    args = std_cmake_args
    # Use brewed FFmpeg rather than precompiled binaries in the repo
    args << "-DUSE_SYSTEM_FFMPEG=ON"

    # fix missing include for zipconf.h
    ENV.append_to_cflags "-I#{Formula["libzip"].opt_prefix}/lib/libzip/include"

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      prefix.install "PPSSPPSDL.app"
      bin.write_exec_script "#{prefix}/PPSSPPSDL.app/Contents/MacOS/PPSSPPSDL"
      mv "#{bin}/PPSSPPSDL", "#{bin}/ppsspp"
    end
  end
end
