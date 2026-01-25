import UIKit

enum Position: String, CaseIterable, Codable {
    case LW, RW, ST
    case CAM, CM, LM, RM
    case CB, RB, LB
    case GK

    var color: UIColor {
        switch self {
        case .ST, .LW, .RW:
            return .systemRed
        case .CAM, .CM, .LM, .RM:
            return .systemGreen
        case .CB, .RB, .LB:
            return .systemBlue
        case .GK:
            return .systemOrange
        }
        
    }
}
