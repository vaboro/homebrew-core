class Lynis < Formula
  desc "Security and system auditing tool to harden systems"
  homepage "https://cisofy.com/lynis/"
  url "https://downloads.cisofy.com/lynis/lynis-3.0.0.tar.gz"
  sha256 "3cc165f9007ba41de6d0b693a1167dbaf0179085f9506dcba64b4b8e37e1bda2"

  livecheck do
    url "https://cisofy.com/downloads/lynis/"
    regex(%r{href=.*?/lynis[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle :unneeded

  def install
    inreplace "lynis" do |s|
      s.gsub! 'tINCLUDE_TARGETS="/usr/local/include/lynis ' \
              '/usr/local/lynis/include /usr/share/lynis/include ./include"',
              %Q(tINCLUDE_TARGETS="#{include}")
      s.gsub! 'tPLUGIN_TARGETS="/usr/local/lynis/plugins ' \
              "/usr/local/share/lynis/plugins /usr/share/lynis/plugins " \
              '/etc/lynis/plugins ./plugins"',
              %Q(tPLUGIN_TARGETS="#{prefix}/plugins")
      s.gsub! 'tDB_TARGETS="/usr/local/share/lynis/db /usr/local/lynis/db ' \
              '/usr/share/lynis/db ./db"',
              %Q(tDB_TARGETS="#{prefix}/db")
    end
    inreplace "include/functions" do |s|
      s.gsub! 'tPROFILE_TARGETS="/usr/local/etc/lynis /etc/lynis ' \
              '/usr/local/lynis ."',
              %Q(tPROFILE_TARGETS="#{prefix}")
    end

    prefix.install "db", "include", "plugins", "default.prf"
    bin.install "lynis"
    man8.install "lynis.8"
  end

  test do
    assert_match "lynis", shell_output("#{bin}/lynis --invalid 2>&1", 64)
  end
end
