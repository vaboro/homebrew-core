class Tile38 < Formula
  desc "In-memory geolocation data store, spatial index, and realtime geofence"
  homepage "https://tile38.com/"
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://github.com/tidwall/tile38/archive/1.17.4.tar.gz"
  sha256 "5ed6e9bdb93c3a20f59ce0bd9856867ea0457612329f1ae3b220d98df984f85c"
=======
  url "https://github.com/tidwall/tile38/archive/1.17.6.tar.gz"
  sha256 "4656b976100dc553742c409e023ecfb7d491767b87e518f55e999e1b26bb1b9e"
>>>>>>> upstream/master
  head "https://github.com/tidwall/tile38.git"

  bottle do
    cellar :any_skip_relocation
<<<<<<< HEAD
    sha256 "f3394c764bfdca7bd4a71a62be774729974f16f124a403a4556a797bfa3c7a37" => :mojave
    sha256 "2f98b1dc7ca3e8a4273370569c666e40e1f5cccce645d6b0e2090fd5c94fc94f" => :high_sierra
    sha256 "81b1856cd61ee093714ce7dc56f864dbc7aae1df4f3a532cfe3506878e97bbd5" => :sierra
=======
    sha256 "f420c16ea95108614a8ef3c660d8f68f24bbb02ffaa84266a6c4248ea27504b7" => :mojave
    sha256 "5c10d7d38dd399445d38b48bdc9d224e0100c0602724b2ab2b312e536b16c3ef" => :high_sierra
    sha256 "58f9522526d8b08f1e7e810b269f092c1259a957da54fb26782c6555311bfa02" => :sierra
>>>>>>> upstream/master
=======
  url "https://github.com/tidwall/tile38.git",
    tag:      "1.22.0",
    revision: "bd572b0d3843b4a33f300653ef70e368370bd50e"
  license "MIT"

  bottle do
    cellar :any_skip_relocation
    sha256 "6e606e977dbe5bf0c286361713f020c085fad931bdb84fd344e9a00b42b50b6f" => :catalina
    sha256 "2cc618a4743e14b1c0603e2f8c3ec7af299bf62ac134cb1b021e375776178704" => :mojave
    sha256 "aa28a00edb4e3208061669510f692005d15668198921a841f135c6d7347149c0" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "go" => :build

  def datadir
    var/"tile38/data"
  end

  def install
    commit = Utils.safe_popen_read("git", "rev-parse", "--short", "HEAD").chomp

    ldflags = %W[
      -s -w
      -X github.com/tidwall/tile38/core.Version=#{version}
      -X github.com/tidwall/tile38/core.GitSHA=#{commit}
    ]

    system "go", "build", "-o", bin/"tile38-server", "-ldflags", ldflags.join(" "), "./cmd/tile38-server"
    system "go", "build", "-o", bin/"tile38-cli", "-ldflags", ldflags.join(" "), "./cmd/tile38-cli"
  end

  def post_install
    # Make sure the data directory exists
    datadir.mkpath
  end

  def caveats
    <<~EOS
      To connect: tile38-cli
    EOS
  end

  plist_options manual: "tile38-server -d #{HOMEBREW_PREFIX}/var/tile38/data"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>KeepAlive</key>
          <dict>
            <key>SuccessfulExit</key>
            <false/>
          </dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{opt_bin}/tile38-server</string>
            <string>-d</string>
            <string>#{datadir}</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
          <key>WorkingDirectory</key>
          <string>#{var}</string>
          <key>StandardErrorPath</key>
          <string>#{var}/log/tile38.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/log/tile38.log</string>
        </dict>
      </plist>
    EOS
  end

  test do
    pid = fork do
      exec "#{bin}/tile38-server", "-q"
    end
    sleep 2
    # remove `$408` in the first line output
    json_output = shell_output("#{bin}/tile38-cli server").lines[1]
    tile38_server = JSON.parse(json_output)
    assert_equal tile38_server["ok"], true
  ensure
    Process.kill("HUP", pid)
  end
end
