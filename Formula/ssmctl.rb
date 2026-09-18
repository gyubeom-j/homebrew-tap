# tools/homebrew가 생성합니다. 토큰이나 로컬 경로를 기록하지 않습니다.
class Ssmctl < Formula
  desc "AWS Systems Manager 세션 접속 도구"
  homepage "https://github.com/gyubeom-j/ssmctl"
  version "0.1.0-rc.3"

  bottle do
    root_url "https://ghcr.io/v2/gyubeom-j/tap"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "879ea3bee9e0bc8c3e67ab067e366430637143543d5232af0f0f1c56323ea44c"
    sha256 cellar: :any_skip_relocation, sequoia:       "31217e14f5136efb712d1270812db0c9ced177bcf3c9b4cf6fc96289ba4422af"
  end

  # 이 URL은 bottle 제작용 입력입니다. 설치 사용자는 bottle을 받습니다.
  on_macos do
    depends_on macos: :sequoia

    on_arm do
      url "https://github.com/gyubeom-j/ssmctl/releases/download/v0.1.0-rc.3/ssmctl_v0.1.0-rc.3_darwin_arm64.tar.gz"
      sha256 "bc8c53027151161b79691b2b84d74ea8770143c4e18faaf985710325b9a52b7c"
    end
    on_intel do
      url "https://github.com/gyubeom-j/ssmctl/releases/download/v0.1.0-rc.3/ssmctl_v0.1.0-rc.3_darwin_amd64.tar.gz"
      sha256 "83bbe052ba82c9d1d92071b9dd06a87ba97fd2bb57febe20c00f7d9696b6b377"
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
    assert_match "v0.1.0-rc.3", shell_output("#{bin}/ssmctl version")
    assert_match "ssmctl", shell_output("#{bin}/ssmctl --help")
    assert_path_exists prefix/"docs/architecture.md"
    assert_path_exists prefix/"licenses/go/LICENSE"
  end
end
