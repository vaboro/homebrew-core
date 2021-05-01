class Prest < Formula
  desc "Serve a RESTful API from any PostgreSQL database"
  homepage "https://github.com/prest/prest"
  url "https://github.com/prest/prest/archive/v1.0.3.tar.gz"
  sha256 "3035e59926967f8f7e094b08c1287681a1e7e53b80c5fd6566a6a9fc9d90115e"
  license "MIT"
  revision 1
  head "https://github.com/prest/prest.git"

  bottle do
    rebuild 1
    sha256 cellar: :any_skip_relocation, catalina:    "ac343c6c877e71e720c54aa587b9ecaa523c2f519c27d38f3fcd0ec4ce27d610"
    sha256 cellar: :any_skip_relocation, mojave:      "cefb4b1a4f50e5ed2b5a97cf1abded81fc7d814a75af4542cfd230af941bb898"
    sha256 cellar: :any_skip_relocation, high_sierra: "3bad786cdca119026b897588f5db24a6ddbe550f33ed58b7ff16c95400dfc25c"
  end

  depends_on "go" => :build

  def install
    cd "cmd/prestd" do
      system "go", "build", *std_go_args, "-ldflags",
            "-s -w -X github.com/prest/helpers.PrestVersionNumber=#{version}"
    end
  end

  test do
    output_regex = /Version (?<migration>\d+) migration files created in .*:/
    output = shell_output("prest migrate create test --path .")
    migration = output.match(output_regex)[:migration]
    assert_predicate testpath/"#{migration}_test.down.sql", :exist?
    assert_predicate testpath/"#{migration}_test.up.sql", :exist?
  end
end
