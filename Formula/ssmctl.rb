# tools/homebrew가 생성합니다. 토큰이나 로컬 경로를 기록하지 않습니다.
class Ssmctl < Formula
  desc "AWS Systems Manager 세션 접속 도구"
  homepage "https://github.com/gyubeom-j/ssmctl"
  version "0.1.0-rc.2"

  bottle do
    root_url "https://ghcr.io/v2/gyubeom-j/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5b5f0f930ac98f411f44a889632645bb7936e515816df36dbe327510650729f1"
    sha256 cellar: :any_skip_relocation, sequoia:       "8cf544eaa77bf3d8a7f59d217b89f06a6749d2a986b8e58885be91bd5be91874"
  end

  # 이 URL은 bottle 제작용 입력입니다. 설치 사용자는 bottle을 받습니다.
  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/gyubeom-j/ssmctl/releases/download/v0.1.0-rc.2/ssmctl_v0.1.0-rc.2_darwin_arm64.tar.gz"
      sha256 "039c06efa93c285a1676541bada4a2b200b1e9e5de2186f3aaf2136ef9d99c99"
    end
    on_intel do
      url "https://github.com/gyubeom-j/ssmctl/releases/download/v0.1.0-rc.2/ssmctl_v0.1.0-rc.2_darwin_amd64.tar.gz"
      sha256 "9ad296116409597d2fd1cf709896bf9828752ec67700bb882fd741013cf4a746"
    end
  end

  depends_on :macos

  def install
    # 비공개 소스를 컴파일하지 않고, CI가 검증한 실행 파일과 문서를 설치합니다.
    bin.install "ssmctl"
    prefix.install "README.md", "docs", "licenses"
  end

  def caveats
    <<~EOS
      AWS 로그인은 사용자가 준비해야 합니다.
      실제 접속에는 별도 Session Manager plugin이 필요합니다.
      문서: #{prefix}/README.md
      기존 ~/.local/bin/ssmctl이 PATH에서 우선하면 이전 버전이 실행될 수 있습니다.
    EOS
  end

  test do
    assert_match "v0.1.0-rc.2", shell_output("#{bin}/ssmctl version")
    assert_match "ssmctl", shell_output("#{bin}/ssmctl --help")
    assert_path_exists prefix/"docs/architecture.md"
    assert_path_exists prefix/"licenses/go/LICENSE"
  end
end
