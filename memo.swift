import Foundation

struct Memo: Codable {
    var title: String
    var items: [Player]
}

struct Player: Codable {
    let position: Position
    let name: String
    let foot: Foot

}

enum Foot: String, CaseIterable, Codable {
    case left = "왼발"
    case right = "오른발"
    case both = "양발"


}
