class Gotapaper < Formula
  desc "Download wallpaper from various sources"
  homepage "https://github.com/genzj/goTApaper"
  url "https://github.com/genzj/goTApaper/archive/v0.4.1.tar.gz"
  sha256 "d7b33717ca60e1cc269a4fa4b3713d131b8a5d746570da12ce2161ac8d6fa1cc"
  license "MIT"
  head "https://github.com/genzj/goTApaper.git"

  GIT_COMMIT_ID="65db40093f962bb6261a4a803b038ae8b59ff196".freeze

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
