# ssmctl Homebrew tap

ssmctl의 Homebrew 설치 정의와 사전 빌드 패키지(bottle)를 관리합니다. 애플리케이션 Go 소스나 인증 토큰은 이 저장소에 포함하지 않습니다.

## 설치

[Homebrew](https://brew.sh/)가 설치된 **macOS 15 이상, Intel·Apple Silicon**에서 사용합니다. 공개 tap과 GHCR 패키지를 이용하므로 **GitHub 로그인·개인 토큰·Go·Docker 설치가 필요하지 않습니다.** 완성된 실행 파일을 설치하며 애플리케이션 소스 저장소는 비공개로 유지합니다.

```bash
brew install --force-bottle gyubeom-j/tap/ssmctl
ssmctl version
ssmctl --help
```

별도 `brew tap`은 필요하지 않습니다. 이 저장소는 Homebrew 공식 저장소가 아닌 개인 tap이므로 최초 설치에는 위 전체 이름을 사용하세요. `--force-bottle`은 사전 빌드 패키지를 사용하는 옵션이며 Apple 보안 검사를 끄는 옵션이 아닙니다.

Linux·macOS 14 이하는 이 tap의 지원 대상이 아닙니다. 비공개 GitHub Releases URL은 패키지 제작용이며 일반 사용자용 다운로드 경로가 아닙니다. 소스 빌드 설치(`--build-from-source`)도 지원하지 않습니다. 버전에 `-rc.N`이 붙어 있으면 정식 버전 이전의 사전 검증용 릴리즈입니다.

## AWS 접속 준비

실제 접속에는 별도 Session Manager plugin이 필요합니다.

```bash
brew install --cask session-manager-plugin
```

본인의 AWS 프로파일·인증·접속 권한을 준비하세요. AWS CLI 로그인 방식을 사용하는 경우 AWS CLI v2도 별도로 설치합니다.

```bash
# AWS CLI 로그인 방식을 사용하는 경우에만 설치
brew install awscli

# 본인의 로그인 방식에 해당하는 명령 하나를 사용합니다.
# prod는 본인의 프로파일 이름으로 바꿉니다.
aws login --profile prod
# IAM Identity Center(SSO)를 쓴다면 위 명령 대신:
# aws sso login --profile prod

ssmctl profiles
ssmctl
```

ssmctl은 AWS 로그인을 대신 수행하지 않습니다. 토큰 만료 시 재로그인을 안내합니다. 접속 대상에는 실행 중인 SSM Agent, SSM 권한이 있는 인스턴스 역할 또는 DHMC, SSM 엔드포인트로의 네트워크 연결이 필요합니다. 목록에는 Online 상태의 SSM 관리 대상 EC2 인스턴스만 표시됩니다.

로그인한 사용자나 역할에는 `ssm:DescribeInstanceInformation`, `ec2:DescribeInstances`, `ssm:StartSession`, `ssm:TerminateSession`, `ssm:ResumeSession` 권한이 필요합니다. 조직의 IAM·SSM 정책에 따라 추가 조건이 적용될 수 있습니다. 검색형 선택 UI가 필요하면 선택적으로 `brew install fzf`를 사용합니다.

설치된 버전의 사용법·아키텍처·코드 구성 문서는 다음 경로에서 확인할 수 있습니다. 소스 저장소에 접근할 필요가 없습니다.

```bash
open "$(brew --prefix ssmctl)/README.md"
open "$(brew --prefix ssmctl)/docs"
```

패키지 내부 문서는 해당 릴리즈 시점의 내용입니다. 예전 패키지에 비공개 인증 안내가 남아 있으면 설치·업데이트 방법은 이 tap README를 기준으로 하세요.

## 업데이트

```bash
brew update
brew upgrade --force-bottle gyubeom-j/tap/ssmctl
ssmctl version
```

## 제거

```bash
brew uninstall gyubeom-j/tap/ssmctl
```

제거해도 `~/.ssmctl`의 캐시·최근 사용 리전·접속 이력과 기존 수동 설치 파일은 유지됩니다.

## 문제 해결

- **이전 실행 파일이 실행됨:** `type -a ssmctl`로 경로를 확인합니다. `~/.local/bin/ssmctl`보다 Homebrew 경로가 우선하도록 PATH를 정리하세요. `"$(brew --prefix ssmctl)/bin/ssmctl" version`으로 Homebrew 파일을 직접 확인할 수 있습니다.
- **코드 신뢰 확인:** [설치 정의](Formula/ssmctl.rb)를 검토하고 필요한 경우 `brew trust --formula gyubeom-j/tap/ssmctl`로 해당 formula만 신뢰한 뒤 다시 설치합니다.
- **401/403/404:** 공개 tap과 패키지 접근 상태를 확인하세요. 일반 사용자는 PAT가 필요하지 않습니다. 이전 비공개 테스트의 인증 환경변수가 없는 새 셸에서도 확인합니다. 기존 tap을 SSH로 추가했다면 Git 주소도 확인하세요.
- **회사 관리 Mac에서 차단:** 관리자 정책을 확인하세요. Apple Developer ID 서명·공증을 제공하는 배포가 아니며, Gatekeeper 전역 해제나 `xattr` 삭제를 설치 절차에 포함하지 않습니다.

문제 제보는 [이 저장소의 Issues](https://github.com/gyubeom-j/homebrew-tap/issues)를 사용하세요. macOS 버전·CPU 종류·`ssmctl version`·오류 메시지를 포함하되 AWS 토큰·계정 정보·인스턴스 정보 등 민감한 내용은 제거합니다.

## 유지관리

ssmctl 저장소의 배포 자동화가 bottle을 만들고 원격 설치를 검증한 다음 한국어 PR을 생성합니다. 버전·체크섬·검증 결과를 확인하고 사람이 머지합니다. 이전 버전의 PR을 나중에 머지하여 설치 버전을 역행시키지 마세요.

이 README의 원본은 소스 저장소의 `tools/homebrew/tap/README.md`입니다. 직접 문서 PR을 만들 때도 원본을 함께 수정하여 다음 배포에서 안내가 되돌아가지 않도록 합니다. 기존 릴리즈나 bottle을 문서 수정 목적으로 덮어쓰지 않습니다.

현재 tap과 `tap/ssmctl` 패키지는 공개이며, 게시용 Secrets는 CI에서만 사용합니다. `lib/ghcr-token.rb`는 비공개 배포 검증을 위한 유지관리 도구로 남겨 두며 일반 사용자 설치에는 필요하지 않습니다. 토큰을 문서·설치 정의·커밋에 기록하지 마세요.
