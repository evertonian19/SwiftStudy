import UIKit

enum Position: String,Codable,CaseIterable {
    case LW, RW, ST
    case CAM, CM, LM, RM, CDM
    case CB, RB, LB
    case GK

    var color: UIColor {
        switch self {
        case .ST, .LW, .RW:
            return .systemRed
        case .CAM, .CM, .LM, .RM, .CDM:
            return .systemGreen
        case .CB, .RB, .LB:
            return .systemBlue
        case .GK:
            return .systemOrange
        }
        
    }
}
