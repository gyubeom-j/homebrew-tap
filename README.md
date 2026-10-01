# ssmctl Homebrew tap

Rust 기반 ssmctl의 Homebrew formula와 사전 빌드 bottle을 관리합니다.
애플리케이션 소스 저장소는 비공개이며, 이 tap과 GHCR bottle은 공개입니다.

## 설치

macOS 15 이상 Apple Silicon·Intel에서 사용합니다.
GitHub 로그인·개인 토큰·Rust compiler·Go·Docker는 필요하지 않습니다.

```sh
brew install --force-bottle gyubeom-j/tap/ssmctl
ssmctl --version
ssmctl --help
```

Linux·macOS 14 이하는 이 tap의 지원 대상이 아닙니다. Formula의 비공개 release
URL은 패키지 제작용이며 일반 사용자는 bottle을 설치합니다.
`--build-from-source` 설치는 지원하지 않습니다.

## AWS 접속

```sh
brew install --cask session-manager-plugin
ssmctl profiles
ssmctl
```

유효한 AWS profile과 SSM 접속 권한을 준비하세요. `ssmctl`은 기본적으로 TUI를
실행하며, AWS 로그인을 대신 수행하지 않습니다. 자격 증명이 만료되면 본인의
인증 방식에 따라 로그인한 뒤 다시 실행합니다. AWS CLI가 필요한 인증 방식을
사용한다면 `brew install awscli`로 별도 설치합니다. fzf는 필요하지 않습니다.

설치된 버전의 문서는 아래에서 확인할 수 있습니다.

```sh
open "$(brew --prefix ssmctl)/README.md"
open "$(brew --prefix ssmctl)/docs"
```

## 업데이트·제거

새 Rust 시험판이 배포되면 다음 명령으로 업데이트합니다.

```sh
brew update
brew upgrade --force-bottle gyubeom-j/tap/ssmctl
ssmctl --version
# 제거할 때:
brew uninstall gyubeom-j/tap/ssmctl
```

제거해도 사용자의 AWS 설정과 `~/.ssmctl` 상태 파일은 유지됩니다.
다른 실행 파일이 선택되면 `type -a ssmctl`로 PATH를 확인하세요.
설치 신뢰 확인이 필요한 경우 formula를 검토하고
`brew trust --formula gyubeom-j/tap/ssmctl`을 사용합니다.
401/403/404가 발생해도 사용자 PAT는 필요하지 않습니다. 이전 비공개 테스트의
인증 환경변수와 tap Git 주소, 공개 package 접근 상태를 확인하세요.
Apple Developer ID 서명·공증은 제공하지 않으며 보안 검사 해제는 설치 절차에 포함하지 않습니다.

문제는 [Issues](https://github.com/gyubeom-j/homebrew-tap/issues)에 macOS 버전,
CPU, `ssmctl --version`, 오류 메시지와 함께 제보해 주세요. AWS 인증 정보와
계정·인스턴스 정보는 제거합니다.

## 유지관리

Rust 저장소의 GitHub Actions가 bottle 제작 및 토큰 없는 신규 설치·재설치와 이전 formula가 있을 때 upgrade를
검증한 뒤 PR을 생성합니다. 버전과 checksum을 확인하고 사람이 merge합니다.
이전 버전 PR을 나중에 merge하여 버전을 되돌리지 마세요.

이 README 원본은 Rust 저장소의 `scripts/release/tap-README.md`입니다.
