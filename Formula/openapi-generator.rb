class OpenapiGenerator < Formula
  desc "Generate clients, server & docs from an OpenAPI spec (v2, v3)"
  homepage "https://openapi-generator.tech/"
<<<<<<< HEAD
<<<<<<< HEAD
  url "https://search.maven.org/remotecontent?filepath=org/openapitools/openapi-generator-cli/4.1.0/openapi-generator-cli-4.1.0.jar"
  sha256 "649accfdd325ef7aff03bd60cec15a39cf2b7f9f51ec1f5e4d29b930e15e715e"
=======
  url "https://search.maven.org/remotecontent?filepath=org/openapitools/openapi-generator-cli/4.1.1/openapi-generator-cli-4.1.1.jar"
  sha256 "5b35261e6144a498207fc52e6c2c9ee935a5dd513e88970154bf59180c458732"
>>>>>>> upstream/master
=======
  url "https://search.maven.org/remotecontent?filepath=org/openapitools/openapi-generator-cli/4.1.2/openapi-generator-cli-4.1.2.jar"
  sha256 "c4e3025ba2c82c24e26178ad451d0e00756ff0e151259ef3814e99feac9ec5a1"
>>>>>>> upstream/master

  head do
    url "https://github.com/OpenAPITools/openapi-generator.git"

    depends_on "maven" => :build
  end

  bottle :unneeded

  depends_on :java => "1.8+"

  def install
    # Need to set JAVA_HOME manually since maven overrides 1.8 with 1.7+
    cmd = Language::Java.java_home_cmd("1.8")
    ENV["JAVA_HOME"] = Utils.popen_read(cmd).chomp
    if build.head?
      system "mvn", "clean", "package", "-Dmaven.javadoc.skip=true"
      libexec.install "modules/openapi-generator-cli/target/openapi-generator-cli.jar"
      bin.write_jar_script libexec/"openapi-generator-cli.jar", "openapi-generator", "$JAVA_OPTS"
    else
      libexec.install "openapi-generator-cli-#{version}.jar"
      bin.write_jar_script libexec/"openapi-generator-cli-#{version}.jar", "openapi-generator", "$JAVA_OPTS"
    end
  end

  test do
    (testpath/"minimal.yaml").write <<~EOS
      ---
      swagger: '2.0'
      info:
        version: 0.0.0
        title: Simple API
      host: localhost
      basePath: /v2
      schemes:
        - http
      paths:
        /:
          get:
            operationId: test_operation
            responses:
              200:
                description: OK
    EOS
    system bin/"openapi-generator", "generate", "-i", "minimal.yaml", "-g", "openapi", "-o", "./"
  end
end
