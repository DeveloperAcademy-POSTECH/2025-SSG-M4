[Tuist Github](https://github.com/tuist/tuist)

## Tuist란?
---
![[Tuist Github Main Image.jpg]]

>Tuist is a command line tool that leverages **_project generation_** to abstract intricacies of Xcode projects, and uses it as a foundation to help teams **_maintain_** and **_optimize_** their large modular projects.
>; Tuist는 ***프로젝트 생성***을 다루는 커맨드라인 도구로, Xcode 프로젝트의 복잡한 부분을 추상화하여 팀이 대규모 [[모듈(Module)]]형 프로젝트를 ***유지보수***하고 ***최적화***하는 데 도움을 줍니다.

### 특징
---
- [[오픈 소스(Open Source)]]
- Swift로 만들어짐
- 권장되는 [설치](https://docs.tuist.dev/en/guides/quick-start/install-tuist)
	- `install mise`
	- `mise install tuist`

### 이점
---
- **Simplify** 🌱
	- 프로젝트 성장 및 멀티플랫폼 확장 시 모듈화 필수
	- 위 과정을 간소화하여 최적화 및 프로젝트 구조에 대한 더 나은 이해를 제공
- **Optimize workflows** 🚀
	- 프로젝트 정보를 다룰 때 선택적 테스트 실행과 빌드마다 동일한 바이너리 재사용을 통한 효율성 개선
- **Foster healthy project evolution** 📈
	- 프로젝트의 흐름을 파악할 수 있는 인사이트와 전문가의 가이드를 제공하여 보다 정확한 의사결정을 지원
- **Break down silos** 💜
	- 플랫폼 종속적인 생태계(Xcode의 폐쇄적인 환경 등)와 달리 웹 중심의 경험을 제공
	- Slack, Prometheus, GitHub와 같은 도구들과 잘 통합되어 도구 간 협업 강화

- **Reduce Git Conflict** 🗑️
	- 프로젝트가 자동 동기화되므로 파일 conflict 방지
- **Enhance Performance** 🫧
	- 불필요한 의존성 제거
	- 런타임과 런치타임 감소
- **Faster Build** 🏎️
	- 캐싱 기능을 통해 모듈을 미리 빌드하므로 빌드 시간 감소

- 참고
	- [요기요 공식 Tuist 적용기](https://techblog.yogiyo.co.kr/ios-프로젝트에-tuist-적용기-1d8f7d489252)
	- [당근 공식 Tuist 적용기](https://medium.com/daangn/xcodegen-에서-tuist-로-전환하기-3f0156e0c2ea)
