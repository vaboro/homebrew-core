class CfnLint < Formula
  include Language::Python::Virtualenv

  desc "Validate CloudFormation templates against the CloudFormation spec"
  homepage "https://github.com/aws-cloudformation/cfn-python-lint/"
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://github.com/aws-cloudformation/cfn-python-lint/archive/v0.23.2.tar.gz"
  sha256 "eb6b6b41444f4255d742d91822fd516ec96192cead4f17bb57370c8fb1c5bcf6"

  bottle do
    cellar :any_skip_relocation
    sha256 "b13f3308bf394cb46add11a659b489d3b378ab9d703cc5a625995451c3c7f976" => :mojave
    sha256 "035966464fcd78b03a42e55d02044f03cedc96abc4e01aff6d878d7275b8443e" => :high_sierra
    sha256 "7285030eb37db8239c97fb598e329d5a8eb871115709bcfc84b57855ff34dd33" => :sierra
=======
  url "https://github.com/aws-cloudformation/cfn-python-lint/archive/v0.24.1.tar.gz"
  sha256 "c2fed29d0cf8d023d96b5a5baf029193e570210d6a8869d68341499cef08ed8a"

  bottle do
    cellar :any_skip_relocation
    sha256 "8cd7906dc939421aa8fafe22456f96ddd5acc634f0bfcd5b67ffe0e8ff1be984" => :mojave
    sha256 "aa73781a1e39c45187ed6fad9b284e6c4db68a8b429af9680a1f657483f8e488" => :high_sierra
    sha256 "d4f3aadb3ef44844d8d992b7f89ce310ea1e62e8d0e5fbd78a468e640c7f39c2" => :sierra
>>>>>>> upstream/master
=======
  url "https://github.com/aws-cloudformation/cfn-python-lint/archive/v0.24.4.tar.gz"
  sha256 "aebcccad5961851d5e432f1ac42c31b25ff649a6b9bca5544e008c8c85c6e18b"

  bottle do
    cellar :any_skip_relocation
    sha256 "09eedf6983870b305504cb57be49a019e6caade70d82a471d24dca5c2beead27" => :catalina
    sha256 "5354e4d8fd2a1990974f2e46d7637d1c66f547c6d87ec53797a787acbd572cb9" => :mojave
    sha256 "5c36673c2308df1248bc97e40de541532380a2f08ee9c6a17ae14b64b9e7cd20" => :high_sierra
>>>>>>> upstream/master
=======
  url "https://files.pythonhosted.org/packages/77/4d/1c57c66d1ed91072518292fc88aabcab94424e7f2a336b949f9ac0b59d90/cfn-lint-0.35.1.tar.gz"
  sha256 "98c7e2c2846df779f1a878e76f3eb7a3f40dd7b7dd316e5673c4923cf2ed121e"
  license "MIT"

  livecheck do
    url :stable
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "014d7b4554effe933e007624c9cb023086a516328a6b2a90e75d2633ddf73e9a" => :catalina
    sha256 "dbc97fc16e4aeec508d33f853fc7a9ad9b4c8060a2be187120e08cf31abbafef" => :mojave
    sha256 "a1356c3630dfdf5e8957cc7184df4654b3ea752b2d7100e454f548ccd60d8790" => :high_sierra
>>>>>>> upstream/master
  end

  depends_on "python@3.8"

  resource "attrs" do
    url "https://files.pythonhosted.org/packages/c4/d4/c2b5232ecfc0783c697a81c13efc53a4fe285d4e2c00e0d8aed90495fade/attrs-20.1.0.tar.gz"
    sha256 "0ef97238856430dcf9228e07f316aefc17e8939fc8507e18c6501b761ef1a42a"
  end

  resource "aws-sam-translator" do
    url "https://files.pythonhosted.org/packages/3f/75/1762399fe43e2af4b90b39fbee8c35dbee73bd43c61666301f802a698bd3/aws-sam-translator-1.26.0.tar.gz"
    sha256 "1a3fd8e48a745967e8457b9cefdc3ad0f139ac4a25af4db9c13a9e1c19ea6910"
  end

  resource "boto3" do
    url "https://files.pythonhosted.org/packages/bb/8a/eff224d84467177305b8b0080d7501aeb2e533b2596d97a0984bec4e957e/boto3-1.14.54.tar.gz"
    sha256 "4196b418598851ffd10cf9d1606694673cbfeca4ddf8b25d4e50addbd2fc60bf"
  end

  resource "botocore" do
    url "https://files.pythonhosted.org/packages/0b/d4/edb5b5a0ddc14bec3b572606f01892331215e9ccc4afc503a2857044c9e0/botocore-1.17.54.tar.gz"
    sha256 "6fe05837646447d61acdaf1e3401b92cd9309f00b19c577a50d0ade7735a3403"
  end

  resource "decorator" do
    url "https://files.pythonhosted.org/packages/da/93/84fa12f2dc341f8cf5f022ee09e109961055749df2d0c75c5f98746cfe6c/decorator-4.4.2.tar.gz"
    sha256 "e3a62f0520172440ca0dcc823749319382e377f37f140a0b99ef45fecb84bfe7"
  end

  resource "docutils" do
    url "https://files.pythonhosted.org/packages/93/22/953e071b589b0b1fee420ab06a0d15e5aa0c7470eb9966d60393ce58ad61/docutils-0.15.2.tar.gz"
    sha256 "a2aeea129088da402665e92e0b25b04b073c04b2dce4ab65caaa38b7ce2e1a99"
  end

  resource "jmespath" do
    url "https://files.pythonhosted.org/packages/3c/56/3f325b1eef9791759784aa5046a8f6a1aff8f7c898a2e34506771d3b99d8/jmespath-0.10.0.tar.gz"
    sha256 "b85d0567b8666149a93172712e68920734333c0ce7e89b78b3e987f71e5ed4f9"
  end

  resource "jsonpatch" do
    url "https://files.pythonhosted.org/packages/69/72/24826f61fe4ba535207ed8efe17c82a5e9f9fdf2247054ae829b5c134b71/jsonpatch-1.26.tar.gz"
    sha256 "e45df18b0ab7df1925f20671bbc3f6bd0b4b556fb4b9c5d97684b0a7eac01744"
  end

  resource "jsonpointer" do
    url "https://files.pythonhosted.org/packages/52/e7/246d9ef2366d430f0ce7bdc494ea2df8b49d7a2a41ba51f5655f68cfe85f/jsonpointer-2.0.tar.gz"
    sha256 "c192ba86648e05fdae4f08a17ec25180a9aef5008d973407b581798a83975362"
  end

  resource "jsonschema" do
    url "https://files.pythonhosted.org/packages/69/11/a69e2a3c01b324a77d3a7c0570faa372e8448b666300c4117a516f8b1212/jsonschema-3.2.0.tar.gz"
    sha256 "c8a85b28d377cc7737e46e2d9f2b4f44ee3c0e1deac6bf46ddefc7187d30797a"
  end

  # only doing this because junit-xml source is not available in PyPI for v1.9
  resource "junit-xml" do
    url "https://github.com/kyrus/python-junit-xml.git",
        revision: "4bd08a272f059998cedf9b7779f944d49eba13a6"
  end

  resource "networkx" do
    url "https://files.pythonhosted.org/packages/ef/d0/f706a9e5814a42c544fa1b2876fc33e5d17e1f2c92a5361776632c4f41ab/networkx-2.5.tar.gz"
    sha256 "7978955423fbc9639c10498878be59caf99b44dc304c2286162fd24b458c1602"
  end

  resource "pyrsistent" do
    url "https://files.pythonhosted.org/packages/9f/0d/cbca4d0bbc5671822a59f270e4ce3f2195f8a899c97d0d5abb81b191efb5/pyrsistent-0.16.0.tar.gz"
    sha256 "28669905fe725965daa16184933676547c5bb40a5153055a8dee2a4bd7933ad3"
  end

  resource "python-dateutil" do
    url "https://files.pythonhosted.org/packages/be/ed/5bbc91f03fa4c839c4c7360375da77f9659af5f7086b7a7bdda65771c8e0/python-dateutil-2.8.1.tar.gz"
    sha256 "73ebfe9dbf22e832286dafa60473e4cd239f8592f699aa5adaf10050e6e1823c"
  end

  resource "PyYAML" do
    url "https://files.pythonhosted.org/packages/64/c2/b80047c7ac2478f9501676c988a5411ed5572f35d1beff9cae07d321512c/PyYAML-5.3.1.tar.gz"
    sha256 "b8eac752c5e14d3eca0e6dd9199cd627518cb5ec06add0de9d32baeee6fe645d"
  end

  resource "s3transfer" do
    url "https://files.pythonhosted.org/packages/50/de/2b688c062107942486c81a739383b1432a72717d9a85a6a1a692f003c70c/s3transfer-0.3.3.tar.gz"
    sha256 "921a37e2aefc64145e7b73d50c71bb4f26f46e4c9f414dc648c6245ff92cf7db"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/6b/34/415834bfdafca3c5f451532e8a8d9ba89a21c9743a0c59fbd0205c7f9426/six-1.15.0.tar.gz"
    sha256 "30639c035cdb23534cd4aa2dd52c3bf48f06e5f4a941509c8bafd8ce11080259"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/81/f4/87467aeb3afc4a6056e1fe86626d259ab97e1213b1dfec14c7cb5f538bf0/urllib3-1.25.10.tar.gz"
    sha256 "91056c15fa70756691db97756772bb1eb9678fa585d9184f24534b100dc60f4a"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"test.yml").write <<~EOS
      ---
      AWSTemplateFormatVersion: '2010-09-09'
      Resources:
        # Helps tests map resource types
        IamPipeline:
          Type: "AWS::CloudFormation::Stack"
          Properties:
            TemplateURL: !Sub 'https://s3.${AWS::Region}.amazonaws.com/bucket-dne-${AWS::Region}/${AWS::AccountId}/pipeline.yaml'
            Parameters:
              DeploymentName: iam-pipeline
              Deploy: 'auto'
    EOS
    system bin/"cfn-lint", "test.yml"
  end
end
