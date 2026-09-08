# PAT를 ssmctl 패키지 읽기 전용의 단기 토큰으로 교환합니다.
# 표준 출력은 비밀 값이므로 반드시 명령 치환으로 받아 사용하세요.
require "net/http"
require "json"

def ssmctl_pull_token(user, pat, transport = Net::HTTP)
  raise "사용자명과 Packages 토큰이 필요합니다" if user.to_s.empty? || pat.to_s.empty?

  uri = URI("https://ghcr.io/token")
  uri.query = URI.encode_www_form(service: "ghcr.io", scope: "repository:gyubeom-j/tap/ssmctl:pull")
  request = Net::HTTP::Get.new(uri)
  request.basic_auth(user, pat)
  # HTTPS 검증을 유지하며 다른 주소로 리다이렉트하지 않습니다.
  response = transport.start(uri.host, uri.port, use_ssl: true, open_timeout: 15, read_timeout: 30) do |http|
    http.request(request)
  end
  raise "GHCR 인증 실패: 읽기 권한과 토큰 만료를 확인해 주세요" unless response.code == "200"

  data = JSON.parse(response.body)
  token = data.is_a?(Hash) && data["token"]
  unless token.is_a?(String) && token.match?(/\A[A-Za-z0-9._~+\/-]+=*\z/)
    raise "GHCR 응답에 유효한 읽기 토큰이 없습니다"
  end
  token
end

if $PROGRAM_NAME == __FILE__
  begin
    puts ssmctl_pull_token(ENV["HOMEBREW_GITHUB_PACKAGES_USER"], ENV["HOMEBREW_GITHUB_PACKAGES_TOKEN"])
  rescue StandardError
    # 응답 본문·예외 상세에는 인증 정보가 포함될 수 있어 출력하지 않습니다.
    warn "[오류] GHCR 읽기 인증에 실패했습니다. 사용자명, read:packages 권한, 만료와 네트워크를 확인해 주세요."
    exit 1
  end
end
