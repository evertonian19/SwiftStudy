
| 단계 | 주제 | 상세 내용 |
| :-- | :--- | :--- |
| **Phase 1** | **Swift 기초** | 변수, 상수, 조건문, 반복문, 함수 등 기초 문법  |
| **Phase 2** | **문법 심화** | `guard let`, `toggle`, `switch`, `optional` 기초 및 활용 |
| **Phase 3** | **로직 활용** | `randomElement` 활용, 메뉴 추천 앱, 가위바위보 게임 구현 |
| **Phase 4-1** | **UIKit CRUD** | `TableView`와 `Alert`을 연동한 데이터 수정 기능 구현 |
| **Phase 4-2** | **UI 개선** | `Bottom Sheet` 및 `ScrollPicker`를 활용한 선택 인터페이스 최적화 |
| **Phase 4-3** | **레이아웃 고도화** | 기존 메모 형태를 이미지 중심의 **카드형 레이아웃**으로 전면 개편 |

### 📌 구현 내용
- UITableView 기반 선수 목록 UI 구성
- 선수 추가 / 삭제 / 수정(CRUD) 기능 구현
- 포지션에 따른 UI 색상 분기 처리
- struct 기반 데이터 모델 설계
- UI 디자인 개편: 단순 텍스트 메모 형태에서 탈피하여, 선수 이미지를 강조한 **카드형(Card View)** UI로 전면 개편
- 이미지 데이터 바인딩:** `UIImageView`를 추가하고 선수별 프로필 사진을 동적으로 매칭
- 시각적 계층 구조(Hierarchy) 개선
  - `Stack View`를 활용하여 선수 정보(국가, 팀, 이름, 주발)를 논리적으로 배치
  - 배경색과 `Corner Radius`를 활용하여 개별 카드의 시인성 확보

## 🛠 Tech Stack
- **Language:** Swift
- **Framework:** UIKit
- **IDE:** Xcode
 
