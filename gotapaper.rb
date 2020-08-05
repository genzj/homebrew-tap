class Gotapaper < Formula
  desc "Download wallpaper from various sources"
  homepage "https://github.com/genzj/goTApaper"
  url "https://github.com/genzj/goTApaper/archive/v0.3.2.tar.gz"
  sha256 "267a3df431b951253056d5c908151ed0f4cc513675783fb29b479964c66afc8e"
  license "MIT"
  head "https://github.com/genzj/goTApaper.git"

  GIT_COMMIT_ID="fd35fee7f9f4e4dd1efb6bd10e5be3f1a473503f".freeze

  depends_on "go" => :build

  def install
    if ENV.key?("HOMEBREW_OVERRIDE_GOPROXY")
      # to support installation from inner network
      ENV["GOPROXY"] = ENV["HOMEBREW_OVERRIDE_GOPROXY"]
    end

    Dir.chdir("#{buildpath}/generate") { system "go", "generate", "-v", "-x" }
    system "go", "build", "-ldflags", "-X github.com/genzj/goTApaper/cmd.Version=#{version} -X github.com/genzj/goTApaper/cmd.GitCommit=#{GIT_COMMIT_ID} -X github.com/genzj/goTApaper/cmd.VersionPrerelease=HomeBrew", *std_go_args
  end

  test do
    assert_equal "goTApaper - #{version} HomeBrew(#{GIT_COMMIT_ID})", shell_output("#{bin}/goTApaper version").strip
  end
end
