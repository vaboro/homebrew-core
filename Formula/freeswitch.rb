class Freeswitch < Formula
  desc "Telephony platform to route various communication protocols"
  homepage "https://freeswitch.org"
  url "https://github.com/signalwire/freeswitch.git",
      tag:      "v1.10.3",
      revision: "129de34d845098b7864a49281f3eb946e0b50314"
  license "MPL-1.1"
  head "https://github.com/signalwire/freeswitch.git"

  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 "e8e37ac077a81b0194ebfcf995d60a9135db73f99e280de0699e22cd62b96ac6" => :catalina
    sha256 "63fa94a3a25cfe4d0942b76143be5a53685292000ca94b0b1bd734a14cb6aa35" => :mojave
    sha256 "f5e6f7a40d0b6582fb0e2b41e0e76681723df812c1fc5c6e3315c46ce2a6158d" => :high_sierra
  end

  depends_on "apr-util" => :build
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "yasm" => :build
  depends_on "ffmpeg"
  depends_on "jpeg"
  depends_on "ldns"
  depends_on "libpq"
  depends_on "libsndfile"
  depends_on "libtiff"
  depends_on "lua"
  depends_on "openssl@1.1"
  depends_on "opus"
  depends_on "pcre"
  depends_on "speex"
  depends_on "speexdsp"
  depends_on "sqlite"

  uses_from_macos "libedit"
  uses_from_macos "zlib"

  on_linux do
    depends_on "util-linux"
  end

  # https://github.com/Homebrew/homebrew/issues/42865

  #----------------------- Begin sound file resources -------------------------
  sounds_url_base = "https://files.freeswitch.org/releases/sounds"

  #---------------
  # music on hold
  #---------------
  moh_version = "1.0.52" # from build/moh_version.txt
  resource "sounds-music-8000" do
    url "#{sounds_url_base}/freeswitch-sounds-music-8000-#{moh_version}.tar.gz"
    version moh_version
    sha256 "2491dcb92a69c629b03ea070d2483908a52e2c530dd77791f49a45a4d70aaa07"
  end
  resource "sounds-music-16000" do
    url "#{sounds_url_base}/freeswitch-sounds-music-16000-#{moh_version}.tar.gz"
    version moh_version
    sha256 "93e0bf31797f4847dc19a94605c039ad4f0763616b6d819f5bddbfb6dd09718a"
  end
  resource "sounds-music-32000" do
    url "#{sounds_url_base}/freeswitch-sounds-music-32000-#{moh_version}.tar.gz"
    version moh_version
    sha256 "4129788a638b77c5f85ff35abfcd69793d8aeb9d7833a75c74ec77355b2657a9"
  end
  resource "sounds-music-48000" do
    url "#{sounds_url_base}/freeswitch-sounds-music-48000-#{moh_version}.tar.gz"
    version moh_version
    sha256 "cc31cdb5b1bd653850bf6e054d963314bcf7c1706a9bf05f5a69bcbd00858d2a"
  end

  #-----------
  # sounds-en
  #-----------
  sounds_en_version = "1.0.52" # from build/sounds_version.txt
  resource "sounds-en-us-callie-8000" do
    url "#{sounds_url_base}/freeswitch-sounds-en-us-callie-8000-#{sounds_en_version}.tar.gz"
    version sounds_en_version
    sha256 "fbe51296ba5282864a8f0269a968de0783b88b2a75dad710ee076138382a5151"
  end
  resource "sounds-en-us-callie-16000" do
    url "#{sounds_url_base}/freeswitch-sounds-en-us-callie-16000-#{sounds_en_version}.tar.gz"
    version sounds_en_version
    sha256 "bf3ac7be99939f57ed4fab7b76d1e47ba78d1573cc72aa0cfe656c559eb097bd"
  end
  resource "sounds-en-us-callie-32000" do
    url "#{sounds_url_base}/freeswitch-sounds-en-us-callie-32000-#{sounds_en_version}.tar.gz"
    version sounds_en_version
    sha256 "9091553934f7ee453646058ff54837f55c5b38be11c987148c63a1cccc88b741"
  end
  resource "sounds-en-us-callie-48000" do
    url "#{sounds_url_base}/freeswitch-sounds-en-us-callie-48000-#{sounds_en_version}.tar.gz"
    version sounds_en_version
    sha256 "9df388d855996a04f6014999d59d4191e22b579f2e8df542834451a25ea3e1cf"
  end

  #------------------------ End sound file resources --------------------------

  def install
    # avoid libks and signalwire-client-c dependencies
    inreplace "build/modules.conf.in", "applications/mod_signalwire",
                                       "#applications/mod_signalwire"

    system "./bootstrap.sh", "-j"

    system "./configure", "--disable-dependency-tracking",
                          "--enable-shared",
                          "--enable-static",
                          "--prefix=#{prefix}",
                          "--exec_prefix=#{prefix}"

    system "make", "all"
    system "make", "install"

    # Should be equivalent to: system "make", "cd-moh-install"
    mkdir_p pkgshare/"sounds/music"
    [8, 16, 32, 48].each do |n|
      resource("sounds-music-#{n}000").stage do
        cp_r ".", pkgshare/"sounds/music"
      end
    end

    # Should be equivalent to: system "make", "cd-sounds-install"
    mkdir_p pkgshare/"sounds/en"
    [8, 16, 32, 48].each do |n|
      resource("sounds-en-us-callie-#{n}000").stage do
        cp_r ".", pkgshare/"sounds/en"
      end
    end
  end

  plist_options manual: "freeswitch -nc -nonat"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>KeepAlive</key>
          <true/>
        <key>Label</key>
          <string>#{plist_name}</string>
        <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/freeswitch</string>
            <string>-nc</string>
            <string>-nonat</string>
          </array>
        <key>RunAtLoad</key>
          <true/>
        <key>ServiceIPC</key>
          <true/>
      </dict>
      </plist>
    EOS
  end

  test do
    system "#{bin}/freeswitch", "-version"
  end
end
