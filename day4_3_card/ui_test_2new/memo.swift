import Foundation

struct Memo: Codable {
    var title: String
    var items: [Player] // 여기 Player는 model.vc에 있는 걸 자동으로 알아챕니다!
}
// 아래에 있던 struct Player, enum Foot 등등은 싹 다 지우세요!
