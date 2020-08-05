# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Gotapaper < Formula
  desc "Download latest pictures from many providers and use them as wallpaper."
  homepage "https://github.com/genzj/goTApaper"
  head "https://github.com/genzj/goTApaper.git"
  url "https://github.com/genzj/goTApaper/archive/v0.3.2.tar.gz"
  sha256 "267a3df431b951253056d5c908151ed0f4cc513675783fb29b479964c66afc8e"
  license "MIT"

  @@commit="fd35fee7f9f4e4dd1efb6bd10e5be3f1a473503f"

  depends_on "go" => :build

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    if ENV.key?("HOMEBREW_OVERRIDE_GOPROXY")
      ENV["GOPROXY"] = ENV["HOMEBREW_OVERRIDE_GOPROXY"]
    end

    Dir.chdir("#{buildpath}/generate") {
      system "go", "generate", "-v", "-x"
    }
    system "go", "build", "-v", "-x", "-ldflags", "-X github.com/genzj/goTApaper/cmd.Version=#{version} -X github.com/genzj/goTApaper/cmd.GitCommit=#{@@commit} -X github.com/genzj/goTApaper/cmd.VersionPrerelease=HomeBrew", *std_go_args
  end

  test do
    assert_equal "goTApaper - #{version} HomeBrew(#{@@commit})", shell_output("#{bin}/goTApaper version").strip
  end
end
