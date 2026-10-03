class Ssmctl < Formula
  desc "AWS Systems Manager session client with a terminal UI"
  homepage "https://github.com/gyubeom-j/ssmctl"
  version "0.1.0-rc.2"

  bottle do
    root_url "https://ghcr.io/v2/gyubeom-j/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "038ff61ca70ca04510064c388d9b56dbd0b46715f3680eb1ada393b66e1b466a"
    sha256 cellar: :any_skip_relocation, sequoia:       "9e0d6e68935bfc99d5d5e0f0962181717262d1bd17751d9fa5f5d26e6911e14d"
  end

  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/gyubeom-j/ssmctl/releases/download/v0.1.0-rc.2/ssmctl_v0.1.0-rc.2_darwin_arm64.tar.gz"
      sha256 "e6ee00e8e1b7f032c452b0a375c56cadc75899fa37ea3861c2df72dbb070f39c"
    end
    on_intel do
      url "https://github.com/gyubeom-j/ssmctl/releases/download/v0.1.0-rc.2/ssmctl_v0.1.0-rc.2_darwin_amd64.tar.gz"
      sha256 "65827716bbf0266729047da810f119b808233035f8de0bde136a2b9de0b7e32c"
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
