import Foundation


let menu = [
    "김치찌개",
    "된장찌개",
    "치킨",
    "피자",
    "초밥",
    "파스타",
    "햄버거",
    "볶음밥",
    "삼겹살",
    "부대찌개"
]

if let todayMenu = menu.randomElement() {
    print("오늘 저녁 메뉴 추천: \(todayMenu)")
} else {
    print("메뉴가 없습니다.")
}

