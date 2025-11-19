import Foundation


let choices = ["가위", "바위", "보"]


let computer = choices.randomElement()!


let user = "가위"

print("사용자: \(user)")
print("컴퓨터: \(computer)")


if user == computer {
    print("결과: 비김")
} else if (user == "가위" && computer == "보") ||
          (user == "바위" && computer == "가위") ||
          (user == "보" && computer == "바위") {
    print("결과: 승리!")
} else {
    print("결과: 패배!")
}
