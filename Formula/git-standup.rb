class GitStandup < Formula
  desc "Git extension to generate reports for standup meetings"
  homepage "https://github.com/kamranahmedse/git-standup"
  url "https://github.com/kamranahmedse/git-standup/archive/2.3.2.tar.gz"
  sha256 "48d5aaa3c585037c950fa99dd5be8a7e9af959aacacde9fe94143e4e0bfcd6ba"
  license "MIT"
  head "https://github.com/kamranahmedse/git-standup.git"

  bottle do
    sha256 cellar: :any_skip_relocation, catalina:    "0a75c65615d92237a59492ac00867d12ab4a23865d85d5cb464d9deb1f6d8ee8"
    sha256 cellar: :any_skip_relocation, mojave:      "0a75c65615d92237a59492ac00867d12ab4a23865d85d5cb464d9deb1f6d8ee8"
    sha256 cellar: :any_skip_relocation, high_sierra: "0a75c65615d92237a59492ac00867d12ab4a23865d85d5cb464d9deb1f6d8ee8"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "git", "init"
    (testpath/"test").write "test"
    system "git", "add", "#{testpath}/test"
    system "git", "commit", "--message", "test"
    system "git", "standup"
  end
end
