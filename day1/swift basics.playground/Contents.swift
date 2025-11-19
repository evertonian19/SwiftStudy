//
//  Day1_SwiftBasics.playground
//  Swift Study Log by Evertonian19
//  Created on 2025-11-10
//
//  주제: Swift 기본 문법 익히기
//  목표: Swift의 문법 흐름과 기본 구조 이해하기
//

import Foundation

// MARK: - 변수(var)와 상수(let)
// var: 값이 변할 수 있음 / let: 한 번 정하면 변경 불가
var name = "에버토니안"
let birthYear = 1997

print("안녕하세요, 저는 \(name)입니다.") //  문자열 보간법 예시

// MARK: - 조건문 (if / else)
if birthYear < 2000 {
    print("20세기에 태어났어요.")
} else {
    print("21세기에 태어났어요")
}

// MARK: - 반복문 (for-in)
for i in 1...3 {
    print("Swift 기본 연습 \(i)회차 🔁")
}

// MARK: - 함수 (func)
// 함수는 특정 동작을 묶어서 재사용 가능하게 만든 코드 블록
func greet(person: String) -> String {
    return "좋은 아침, \(person)! "
}

// 함수 실행
print(greet(person: name))

// MARK: - 도전과제: 직접 만든 함수 실행해보기
// 입력한 숫자의 제곱을 반환하는 함수
func square(of number: Int) -> Int {
    return number * number
}

let result = square(of: 9)
print("9의 제곱은 \(result) 입니다. ")

// 1. Swift는 let/var로 값 선언
// 2. print()로 문자열 출력
// 3. if / for / func 문법 구조를 익힘
// 4. Playground는 콘솔에서 즉시 결과를 확인하기 좋은 환경

