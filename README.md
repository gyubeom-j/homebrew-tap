# ssmctl Homebrew tap

ssmctl의 Homebrew 설치 정의와 사전 빌드 패키지(bottle)를 관리합니다. 애플리케이션 Go 소스나 인증 토큰은 이 저장소에 포함하지 않습니다.

## 현재 상태

초기 배포 준비 상태입니다. `Formula/ssmctl.rb`를 추가하는 검증된 배포 PR이 main에 머지되기 전에는 설치할 수 없습니다. 비공개 테스트가 끝나기 전까지 저장소와 GHCR 패키지 모두 비공개로 유지합니다.

## 설치

첫 배포가 완료된 뒤 사용합니다. 비공개 상태에서는 tap의 Git 읽기 권한과 GHCR 패키지 읽기 권한이 각각 필요합니다.

```bash
brew tap gyubeom-j/tap git@github.com:gyubeom-j/homebrew-tap.git
# GitHub Packages 인증 환경변수를 준비한 뒤 실행
brew install --force-bottle gyubeom-j/tap/ssmctl
ssmctl version
```

`HOMEBREW_GITHUB_PACKAGES_USER`와 `HOMEBREW_GITHUB_PACKAGES_TOKEN`은 사용자 환경에서 안전하게 준비합니다. 패키지 읽기에는 classic PAT의 `read:packages` 권한과 대상 패키지 접근 권한이 필요합니다. 토큰을 formula·문서·커밋에 기록하지 마세요.

지원 범위는 macOS 15 이상, Intel·Apple Silicon입니다. Go 설치나 소스 빌드가 필요하지 않습니다. 실제 AWS 접속에는 사용자 로그인과 Session Manager plugin이 별도로 필요합니다.

## 업데이트

```bash
brew update
brew upgrade --force-bottle gyubeom-j/tap/ssmctl
```

이 tap은 Homebrew 공식 저장소가 아닙니다. 설치 정의를 검토하고 필요한 경우 해당 formula만 신뢰하세요. Apple 보안을 해제하는 명령은 설치 과정에 포함하지 않습니다.

## 유지관리

ssmctl 저장소의 배포 자동화가 bottle을 만들고 원격 설치를 검증한 다음 한국어 PR을 생성합니다. 버전·체크섬·검증 결과를 확인하고 사람이 머지합니다. 이전 버전의 PR을 나중에 머지하여 설치 버전을 역행시키지 마세요.

공개 배포 시에는 이 저장소와 GHCR의 `tap/ssmctl` 패키지를 각각 검토하여 공개합니다. 소스 저장소 공개는 별도 선택 사항입니다. 공개 전환 뒤에는 인증 없는 깨끗한 환경에서 설치를 다시 확인하고 이 README의 인증 안내도 갱신하세요.
