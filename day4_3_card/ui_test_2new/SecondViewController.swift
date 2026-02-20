import UIKit

final class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var memo: Memo!
    var onUpdate: ((Memo) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        assert(memo != nil)

        title = memo.title

        tableView.dataSource = self
        tableView.delegate = self

        let image = UIImage(systemName: "plus.circle.fill")
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(addItemTapped)
        )
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onUpdate?(memo)
    }

    @objc private func addItemTapped() {
        presentAddSheet()
    }

    private func presentEditSheet(player: Player, index: Int) {
        let editVC = EditPlayerViewController(player: player, index: index)
        editVC.onSave = { [weak self] updated, idx in
            guard let self else { return }
            self.memo.items[idx] = updated
            self.tableView.reloadRows(at: [IndexPath(row: idx, section: 0)], with: .automatic)
        }

        let nav = UINavigationController(rootViewController: editVC)
        nav.modalPresentationStyle = .fullScreen // 이 줄 추가!

            present(nav, animated: true) // 딱 한 번만 깔끔하게 호출
        
        }
    

    private func presentAddSheet() {
        let defaultPlayer = Player(
            name: "",
            position: .LW,
            foot: .both,
            country: "Unknown",
            club: "No Club",
            imageName: "" // Assets에 있는 기본 이미지 이름
        )

        let editVC = EditPlayerViewController(player: defaultPlayer, index: -1)
        editVC.onSave = { [weak self] updated, _ in
            guard let self else { return }
            self.memo.items.append(updated)
            self.tableView.reloadData()
        }

        let nav = UINavigationController(rootViewController: editVC)
        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 16
        }
        present(nav, animated: true)
    }

    
}
extension SecondViewController: UITableViewDataSource {
    
    // ⭐ [추가] 테이블뷰의 줄 개수를 알려주는 필수 함수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memo.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as? PlayerCell else {
            return UITableViewCell()
            
            
        }
        
        // 💡 playerList 대신 memo.items를 사용하세요!
        let player = memo.items[indexPath.row]
        
        cell.configure(with: player)
        
        return cell
        
    }
}
    // 💡 이 자격증(별채)이 없어서 위에서 에러가 났던 거예요!
    extension SecondViewController: UITableViewDelegate {
        
        // 일단 비워둬도 좋고, 나중에 배울 '스와이프 삭제' 같은 걸 여기 넣는 거예요.
        // 지금은 자격증만 따두면 위쪽 빨간 줄이 사라집니다.
        
        func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let delete = UIContextualAction(style: .destructive, title: "삭제") { [weak self] _, _, completion in
                self?.memo.items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                completion(true)
            }
            return UISwipeActionsConfiguration(actions: [delete])
            
        }
        
    
    
}

