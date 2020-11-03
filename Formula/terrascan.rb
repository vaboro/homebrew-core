class Terrascan < Formula
  desc "Detect compliance and security violations across Infrastructure as Code"
  homepage "https://www.accurics.com/products/terrascan/"
  url "https://github.com/accurics/terrascan/archive/v1.1.0.tar.gz"
  sha256 "4ebca4331c69fb4e11ffbe2699e19ba4354d51b597cbad5188dd39331230f8cb"
  license "Apache-2.0"
  head "https://github.com/accurics/terrascan.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "58d110ee51c8c910cf09561aec034fd7bd8c149159fb91b9da9fc93506c0fc2c" => :catalina
    sha256 "88665e1348a8d54a64fb902718f055727d744127707eb0bda18ce699202e4206" => :mojave
    sha256 "2d94a5b1142130bd73c3b38e1989c0b5401f248d3876cf44fa86f20045adc27a" => :high_sierra
  end

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "./cmd/terrascan"
  end

  test do
    (testpath/"ami.tf").write <<~EOS
      resource "aws_ami" "example" {
        name                = "terraform-example"
        virtualization_type = "hvm"
        root_device_name    = "/dev/xvda"

        ebs_block_device {
          device_name = "/dev/xvda"
          snapshot_id = "snap-xxxxxxxx"
          volume_size = 8
        }
      }
    EOS

    expected = <<~EOS
      results:
        violations: []
        count:
          low: 0
          medium: 0
          high: 0
          total: 0
    EOS

    assert_match expected, shell_output("#{bin}/terrascan scan -f ami.tf -t aws")

    assert_match "version: v#{version}", shell_output("#{bin}/terrascan version")
  end
end
