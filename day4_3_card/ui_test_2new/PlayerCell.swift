import UIKit

final class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var footLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var clubCountryLabel: UILabel! // 새로 만든 국적 라벨
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        // 1. 카드뷰 기본 설정
        cardView.layer.cornerRadius = 12
        cardView.backgroundColor = .white
        cardView.layer.masksToBounds = false
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cardView.layer.shadowRadius = 4
        cardView.layer.shadowOpacity = 0.1
        
        // 2. [가장 중요] 이미지 뷰 설정
        playerImageView.contentMode = .scaleAspectFill
        playerImageView.clipsToBounds = true
        // 만약 스토리보드에서 크기를 60x60으로 잡았다면:
        playerImageView.layer.cornerRadius = 30
        
        // 3. 포지션 라벨
        positionLabel.layer.cornerRadius = 6
        positionLabel.clipsToBounds = true
        
        // 💡 [테스트용] 사진 안 나오면 범인 잡으려고 배경색 넣기
        playerImageView.backgroundColor = .systemGray5
    
        
    }
    
    func configure(with player: Player) {
        // 1. 포지션 설정
        positionLabel.text = player.position.rawValue
        positionLabel.textColor = player.position.color
        positionLabel.font = .boldSystemFont(ofSize: 15)
        positionLabel.backgroundColor = player.position.color.withAlphaComponent(0.15)
        
        // 2. 이름 및 상세 정보
        nameLabel.text = player.name
        footLabel.text = (player.foot.rawValue)
        
        // 3. 국가 및 팀 (데이터매니저에서 가져온 정보)
        clubCountryLabel.text = "\(player.country) | \(player.club)"
        print("📢 셀에 전달된 이미지 이름: [\(player.imageName)]")
        // 4. [중요] 사진 띄우기 (이름으로 직접 찾기!)
        if let image = UIImage(named: player.imageName) {
            playerImageView.image = image
        } else {
            // 사진이 없으면 기본 아이콘 띄우기
            playerImageView.image = UIImage(systemName: "person.circle.fill")
        
        }
    }
    // PlayerCell.swift 내부

}
