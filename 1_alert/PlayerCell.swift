import UIKit

final class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var footLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    

        
        positionLabel.layer.cornerRadius = 6
        positionLabel.clipsToBounds = true
    }

    func configure(position: Position, name: String, foot: Foot) {
        positionLabel.text = position.rawValue
        positionLabel.textColor = position.color
        positionLabel.font = .boldSystemFont(ofSize: 15)
        positionLabel.backgroundColor = position.color.withAlphaComponent(0.15)

        nameLabel.text = name
        footLabel.text = foot.rawValue
    }

        
    }

