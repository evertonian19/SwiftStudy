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
        // sheetPresentationController 설정 코드는 지워도 돼.
        present(nav, animated: true)
        // --- 여기서부터 추가 ---
            nav.modalPresentationStyle = .fullScreen// A번 추가 (핵심!)
            // --- 여기까지 추가 ---

            present(nav, animated: true) // 딱 한 번만 깔끔하게 호출
        
        }
    

    private func presentAddSheet() {
        let defaultPlayer = Player(position: Position.allCases[0], name: "", foot: Foot.allCases[0])

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

// MARK: - TableView DataSource
extension SecondViewController: UITableViewDataSource {

    // 메모 안에 있는 내용 개수만큼 셀 생성
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return memo.items.count
    }

    // 메모 안의 내용 표시
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "PlayerCell",
            for: indexPath
        ) as? PlayerCell else {
            fatalError("PlayerCell dequeue 실패")
        }


        
        let player = memo.items[indexPath.row]

        cell.configure(
            position: player.position,
            name: player.name,
            foot: player.foot
        )

        return cell
    }

}

// MARK: - TableView Delegate
extension SecondViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {

        // 1️⃣ 삭제 액션
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] _, _, completion in
            guard let self else { return }
            self.memo.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }

        // 2️⃣ 편집 액션
        let editAction = UIContextualAction(style: .normal, title: "편집") { [weak self] _, _, completion in
            guard let self else { return }
            let player = self.memo.items[indexPath.row]
            self.presentEditSheet(player: player, index: indexPath.row)
            completion(true)
        }
        editAction.backgroundColor = .systemBlue

        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        config.performsFirstActionWithFullSwipe = false
        return config
    }


}
