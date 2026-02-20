import UIKit

// 1. 여기서만 Player를 정의합니다!
struct Player: Codable {
    let name: String
    let position: Position
    let foot: Foot
    let country: String
    let club: String
    let imageName: String
}

// 2. Foot도 여기에 모아두면 편해요
enum Foot: String, CaseIterable, Codable {
    case left = "왼발"
    case right = "오른발"
    case both = "양발"
}
struct PlayerDataManager {
    static let sharedList: [Player] = [
        // MARK: - Man City
        Player(name: "Erling Haaland", position: .ST, foot: .left, country: "Norway", club: "Man City", imageName: "haaland"),
        Player(name: "Kevin De Bruyne", position: .CM, foot: .right, country: "Belgium", club: "Man City", imageName: "debruyne"),
        Player(name: "Phil Foden", position: .RW, foot: .left, country: "England", club: "Man City", imageName: "foden"),
        Player(name: "Rodri", position: .CDM, foot: .right, country: "Spain", club: "Man City", imageName: "rodri"),
        Player(name: "Bernardo Silva", position: .CM, foot: .left, country: "Portugal", club: "Man City", imageName: "bernardo"),
        Player(name: "Jack Grealish", position: .LW, foot: .right, country: "England", club: "Everton", imageName: "jack_grealish"),
        Player(name: "Ruben Dias", position: .CB, foot: .right, country: "Portugal", club: "Man City", imageName: "dias"),
        Player(name: "Ederson", position: .GK, foot: .left, country: "Brazil", club: "Man City", imageName: "ederson"),
        Player(name: "Jeremy Doku", position: .LW, foot: .right, country: "Belgium", club: "Man City", imageName: "doku"),
        Player(name: "Josko Gvardiol", position: .CB, foot: .left, country: "Croatia", club: "Man City", imageName: "gvardiol"),
        Player(name: "Kyle Walker", position: .RB, foot: .right, country: "England", club: "Man City", imageName: "walker"),
        Player(name: "Mateo Kovacic", position: .CM, foot: .right, country: "Croatia", club: "Man City", imageName: "kovacic"),
        Player(name: "Nathan Ake", position: .CB, foot: .left, country: "Netherlands", club: "Man City", imageName: "ake"),
        Player(name: "John Stones", position: .CB, foot: .right, country: "England", club: "Man City", imageName: "stones"),

        // MARK: - Arsenal
        Player(name: "Bukayo Saka", position: .RW, foot: .left, country: "England", club: "Arsenal", imageName: "saka"),
        Player(name: "Martin Odegaard", position: .CAM, foot: .left, country: "Norway", club: "Arsenal", imageName: "odegaard"),
        Player(name: "Declan Rice", position: .CDM, foot: .right, country: "England", club: "Arsenal", imageName: "rice"),
        Player(name: "William Saliba", position: .CB, foot: .right, country: "France", club: "Arsenal", imageName: "saliba"),
        Player(name: "Gabriel Magalhaes", position: .CB, foot: .left, country: "Brazil", club: "Arsenal", imageName: "gabriel"),
        Player(name: "Kai Havertz", position: .ST, foot: .left, country: "Germany", club: "Arsenal", imageName: "havertz"),
        Player(name: "Gabriel Martinelli", position: .LW, foot: .right, country: "Brazil", club: "Arsenal", imageName: "martinelli"),
        Player(name: "David Raya", position: .GK, foot: .right, country: "Spain", club: "Arsenal", imageName: "raya"),
        Player(name: "Ben White", position: .RB, foot: .right, country: "England", club: "Arsenal", imageName: "white"),
        Player(name: "Leandro Trossard", position: .LW, foot: .right, country: "Belgium", club: "Arsenal", imageName: "trossard"),
        Player(name: "Thomas Partey", position: .CDM, foot: .right, country: "Ghana", club: "Arsenal", imageName: "partey"),
        Player(name: "Gabriel Jesus", position: .ST, foot: .right, country: "Brazil", club: "Arsenal", imageName: "jesus"),

        // MARK: - Liverpool
        Player(name: "Mohamed Salah", position: .RW, foot: .left, country: "Egypt", club: "Liverpool", imageName: "salah"),
        Player(name: "Virgil van Dijk", position: .CB, foot: .right, country: "Netherlands", club: "Liverpool", imageName: "vandijk"),
        Player(name: "Trent Alexander-Arnold", position: .RB, foot: .right, country: "England", club: "Liverpool", imageName: "trent"),
        Player(name: "Alisson Becker", position: .GK, foot: .right, country: "Brazil", club: "Liverpool", imageName: "alisson"),
        Player(name: "Alexis Mac Allister", position: .CM, foot: .right, country: "Argentina", club: "Liverpool", imageName: "macallister"),
        Player(name: "Luis Diaz", position: .LW, foot: .right, country: "Colombia", club: "Liverpool", imageName: "diaz"),
        Player(name: "Darwin Nunez", position: .ST, foot: .right, country: "Uruguay", club: "Liverpool", imageName: "nunez"),
        Player(name: "Dominik Szoboszlai", position: .CM, foot: .right, country: "Hungary", club: "Liverpool", imageName: "szoboszlai"),
        Player(name: "Andrew Robertson", position: .LB, foot: .left, country: "Scotland", club: "Liverpool", imageName: "robertson"),
        Player(name: "Cody Gakpo", position: .LW, foot: .right, country: "Netherlands", club: "Liverpool", imageName: "gakpo"),
        Player(name: "Diogo Jota", position: .ST, foot: .right, country: "Portugal", club: "Liverpool", imageName: "jota"),
        Player(name: "Ibrahima Konate", position: .CB, foot: .right, country: "France", club: "Liverpool", imageName: "konate"),

        // MARK: - Tottenham
        Player(name: "Son Heung-min", position: .LW, foot: .both, country: "South Korea", club: "Tottenham", imageName: "son"),
        Player(name: "James Maddison", position: .CAM, foot: .right, country: "England", club: "Tottenham", imageName: "maddison"),
        Player(name: "Cristian Romero", position: .CB, foot: .right, country: "Argentina", club: "Tottenham", imageName: "romero"),
        Player(name: "Micky van de Ven", position: .CB, foot: .left, country: "Netherlands", club: "Tottenham", imageName: "vandeven"),
        Player(name: "Dejan Kulusevski", position: .RW, foot: .left, country: "Sweden", club: "Tottenham", imageName: "kulusevski"),
        Player(name: "Guglielmo Vicario", position: .GK, foot: .right, country: "Italy", club: "Tottenham", imageName: "vicario"),
        Player(name: "Pedro Porro", position: .RB, foot: .right, country: "Spain", club: "Tottenham", imageName: "porro"),
        Player(name: "Brennan Johnson", position: .RW, foot: .right, country: "Wales", club: "Tottenham", imageName: "johnson"),
        Player(name: "Yves Bissouma", position: .CDM, foot: .right, country: "Mali", club: "Tottenham", imageName: "bissouma"),
        Player(name: "Destiny Udogie", position: .LB, foot: .left, country: "Italy", club: "Tottenham", imageName: "udogie"),

        // MARK: - Chelsea
        Player(name: "Cole Palmer", position: .CAM, foot: .left, country: "England", club: "Chelsea", imageName: "palmer"),
        Player(name: "Enzo Fernandez", position: .CM, foot: .right, country: "Argentina", club: "Chelsea", imageName: "enzo"),
        Player(name: "Moises Caicedo", position: .CDM, foot: .right, country: "Ecuador", club: "Chelsea", imageName: "caicedo"),
        Player(name: "Nicolas Jackson", position: .ST, foot: .right, country: "Senegal", club: "Chelsea", imageName: "jackson"),
        Player(name: "Christopher Nkunku", position: .CAM, foot: .right, country: "France", club: "Chelsea", imageName: "nkunku"),
        Player(name: "Reece James", position: .RB, foot: .right, country: "England", club: "Chelsea", imageName: "james"),
        Player(name: "Levi Colwill", position: .CB, foot: .left, country: "England", club: "Chelsea", imageName: "colwill"),

        // MARK: - Man Utd
        Player(name: "Bruno Fernandes", position: .CAM, foot: .right, country: "Portugal", club: "Man Utd", imageName: "bruno"),
        Player(name: "Marcus Rashford", position: .LW, foot: .right, country: "England", club: "Man Utd", imageName: "rashford"),
        Player(name: "Rasmus Hojlund", position: .ST, foot: .left, country: "Denmark", club: "Man Utd", imageName: "hojlund"),
        Player(name: "Kobbie Mainoo", position: .CM, foot: .right, country: "England", club: "Man Utd", imageName: "mainoo"),
        Player(name: "Alejandro Garnacho", position: .RW, foot: .right, country: "Argentina", club: "Man Utd", imageName: "garnacho"),
        Player(name: "Andre Onana", position: .GK, foot: .right, country: "Cameroon", club: "Man Utd", imageName: "onana"),
        Player(name: "Lisandro Martinez", position: .CB, foot: .left, country: "Argentina", club: "Man Utd", imageName: "martinez"),
        Player(name: "Matthijs de Ligt", position: .CB, foot: .right, country: "Netherlands", club: "Man Utd", imageName: "deligt"),

        // MARK: - Aston Villa
        Player(name: "Ollie Watkins", position: .ST, foot: .right, country: "England", club: "Aston Villa", imageName: "watkins"),
        Player(name: "Emiliano Martinez", position: .GK, foot: .right, country: "Argentina", club: "Aston Villa", imageName: "emartinez"),
        Player(name: "Douglas Luiz", position: .CM, foot: .right, country: "Brazil", club: "Aston Villa", imageName: "douglas"),
        Player(name: "Leon Bailey", position: .RW, foot: .left, country: "Jamaica", club: "Aston Villa", imageName: "bailey"),
        Player(name: "John McGinn", position: .CM, foot: .left, country: "Scotland", club: "Aston Villa", imageName: "mcginn"),

        // MARK: - Newcastle
        Player(name: "Alexander Isak", position: .ST, foot: .right, country: "Sweden", club: "Newcastle", imageName: "isak"),
        Player(name: "Bruno Guimaraes", position: .CDM, foot: .right, country: "Brazil", club: "Newcastle", imageName: "guimaraes"),
        Player(name: "Anthony Gordon", position: .LW, foot: .right, country: "England", club: "Newcastle", imageName: "gordon"),
        Player(name: "Kieran Trippier", position: .RB, foot: .right, country: "England", club: "Newcastle", imageName: "trippier"),

        // MARK: - Others (Brighton, West Ham, etc.)
        Player(name: "Kaoru Mitoma", position: .LW, foot: .right, country: "Japan", club: "Brighton", imageName: "mitoma"),
        Player(name: "Evan Ferguson", position: .ST, foot: .right, country: "Ireland", club: "Brighton", imageName: "ferguson"),
        Player(name: "Jarrod Bowen", position: .RW, foot: .left, country: "England", club: "West Ham", imageName: "bowen"),
        Player(name: "Mohammed Kudus", position: .RW, foot: .left, country: "Ghana", club: "West Ham", imageName: "kudus"),
        Player(name: "Lucas Paqueta", position: .CAM, foot: .left, country: "Brazil", club: "West Ham", imageName: "paqueta")
    ]
}
