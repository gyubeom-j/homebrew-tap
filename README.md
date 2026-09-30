# ssmctl Homebrew tap

Rust 기반 ssmctl의 첫 시험판 `v0.1.0-rc.1` 배포를 준비하고 있습니다.
기존 Go 시험판의 formula와 인증 helper는 제거했습니다.
현재 설치 가능한 formula는 없으며 Rust 배포 검증 후 추가됩니다.

배포 완료 후 macOS 15 이상 Apple Silicon·Intel에서 설치할 수 있습니다.

```sh
brew install --force-bottle gyubeom-j/tap/ssmctl
brew install --cask session-manager-plugin
ssmctl --version
ssmctl
```

애플리케이션 소스는 비공개이며 배포 bottle은 공개 GHCR을 사용합니다.
이 tap은 GitHub Actions를 실행하지 않습니다. Rust 저장소에서 빌드·설치 검증 후
formula 갱신 PR을 생성합니다.
