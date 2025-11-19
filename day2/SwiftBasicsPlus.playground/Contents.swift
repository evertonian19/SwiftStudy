
import Foundation

// MARK: - Day 2 Swift Basic Study

// 1. guard let
func greet(_ name: String?) {
    guard let name = name else {
        print("이름 없음")
        return
    }
    print("안녕하세요, \(name)님!")
}

greet(nil)
greet("타배")


// 2. toggle
var isOn = false
print("초기값:", isOn)
isOn.toggle()
print("토글 후:", isOn)


// 3. for 반복문
var hp = 20
let damage = 3

for turn in 1...5 {
    hp -= damage
    print("턴 \(turn): HP = \(hp)")

    if hp <= 0 {
        print("몬스터 처치 완료!")
        break
    }
}


// 4. switch 기본
let score = 82

switch score {
case 90...100:
    print("A등급")
case 80..<90:
    print("B등급")
case 70..<80:
    print("C등급")
default:
    print("D등급 이하")
}


// 5. function 기본
func add(_ a: Int, _ b: Int) -> Int {
    return a + b
}

print("3 + 5 =", add(3, 5))


// 6. optional 연습
var nickname: String? = "jay-z barry"
print(nickname ?? "닉네임 없음")

nickname = nil
print(nickname ?? "닉네임 없음")

