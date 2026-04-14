
---
|-----|------|-------------|
| 1 | 변수, 상수, 조건문, 반복문, 함수 등 기초 다지기 |
| 2 | guard let, toggle, 반복문, switch, 간단 함수, optional 기초 |
| 3 | randomElement 활용 / 메뉴추천 / 가위바위보 게임 |
| 4-1 | UIKit CRUD (Alert) | TableView + Alert 수정 |
| 4-2 | UIKit 선택 UI 개선 | Bottom Sheet + ScrollPicker |
| 4-3 | 리스트 UI 고도화 (카드형 레이아웃) | 메모 형태를 이미지 중심의 카드 UI로 전면 개편 |
---


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


 
