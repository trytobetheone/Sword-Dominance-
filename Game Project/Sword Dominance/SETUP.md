# 개발 환경 설정 가이드

## 필수 소프트웨어

### 1. Godot Engine 4.2
- **다운로드**: https://godotengine.org/download
- **권장 버전**: 4.2.x (LTS)
- **설치 방법**:
  1. 위 링크에서 Godot 4.2 다운로드
  2. 압축 해제 또는 설치
  3. 실행하여 설치 완료

### 2. Git
- **다운로드**: https://git-scm.com/download
- **설치 완료 확인**: 터미널에서 `git --version` 입력

## 프로젝트 클론 및 열기

### 1단계: 프로젝트 클론
```bash
git clone https://github.com/trytobetheone/Sword-Dominance-.git
cd "Sword-Dominance-"
```

### 2단계: Godot에서 열기
1. Godot 실행
2. **Project Manager** 창에서 **Open** 클릭
3. 프로젝트 폴더 선택 (`Sword-Dominance-`)
4. **Open** 클릭하면 프로젝트 자동 초기화

### 3단계: 개발 시작
- 좌측 FileSystem에서 `res://` 구조 확인
- `scenes/` 폴더에서 씬 생성
- `scripts/` 폴더에서 GDScript 작성

## 폴더 구조

```
Sword-Dominance-/
├── project.godot          # Godot 프로젝트 설정
├── scenes/                # 게임 씬 (.tscn 파일)
├── scripts/               # GDScript 코드 (.gd 파일)
├── assets/
│   ├── images/           # 스프라이트, 배경
│   └── audio/            # 음악, 효과음
├── docs/                 # 문서
└── README.md
```

## Git 워크플로우

### 개발 시작
```bash
# 최신 코드 가져오기
git pull origin main

# 새 기능 브랜치 생성
git checkout -b feature/player-animation

# 작업 후 커밋
git add .
git commit -m "[feat] 플레이어 애니메이션 추가"

# 원격에 푸시
git push origin feature/player-animation

# GitHub에서 Pull Request 생성
```

### 커밋 메시지 규칙
```
[타입] 제목

상세 설명 (필요시)

예:
[feat] 플레이어 이동 시스템 구현
- 좌우 이동 구현
- 애니메이션 추가

[fix] 점프 버그 수정
```

## Godot 단축키

| 단축키 | 기능 |
|--------|------|
| F5 | 게임 실행 |
| F8 | 게임 일시정지 |
| Ctrl+S | 저장 |
| Ctrl+K | 씬 생성 |

## 문제 해결

### Godot에서 프로젝트를 열 수 없음
- Godot 버전 확인 (4.2 필요)
- `project.godot` 파일 존재 확인

### Git 푸시 실패
```bash
# 최신 코드 가져오기
git pull origin main

# 다시 푸시
git push origin [branch-name]
```

### 파일 충돌 발생
- CONTRIBUTING.md의 협업 가이드 참고
- 팀원과 소통하여 해결

## 추가 리소스

- **Godot 문서**: https://docs.godotengine.org/
- **GDScript 튜토리얼**: https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/index.html
- **프로젝트 위키**: GitHub 저장소의 Wiki 탭

---

문제가 있으면 GitHub Issues에 등록해주세요!
