class Ssmctl < Formula
  desc "AWS Systems Manager session client with a terminal UI"
  homepage "https://github.com/gyubeom-j/ssmctl"
  version "0.1.0-rc.1"

  bottle do
    root_url "https://ghcr.io/v2/gyubeom-j/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2c84f9faf0a8bec3dffa58f070177a9e4f10b5c8cb642dbc933ef1f2dd7c7cbf"
    sha256 cellar: :any_skip_relocation, sequoia:       "0610a53c2a7de367b632b66d0444e4f3748a4363135a3cd14eede6066599a691"
  end

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/gyubeom-j/ssmctl/releases/download/v0.1.0-rc.1/ssmctl_v0.1.0-rc.1_darwin_arm64.tar.gz"
      sha256 "309159d776e63c5bee40a8c3d538d66434011e899b3163c6465c6628f4c49414"
    end
    on_intel do
      url "https://github.com/gyubeom-j/ssmctl/releases/download/v0.1.0-rc.1/ssmctl_v0.1.0-rc.1_darwin_amd64.tar.gz"
      sha256 "8f622965f7f595433419f7c7fa35b7375966a0cceffda665adcde6080b02fd62"
    end
  end

  depends_on :macos

  def install
    bin.install "ssmctl"
    prefix.install "README.md", "docs", "licenses"
  end

  def caveats
    "SSM sessions require: brew install --cask session-manager-plugin"
  end

  test do
    assert_equal "ssmctl v#{version}", shell_output("#{bin}/ssmctl --version").strip
    assert_match "usage: ssmctl", shell_output("#{bin}/ssmctl --help")
    assert_path_exists prefix/"licenses"
  end
end
