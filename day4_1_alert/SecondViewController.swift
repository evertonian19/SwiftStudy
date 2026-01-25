import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memo: Memo!
    var selectedPosition: Position?
    var selectedFoot: Foot?
    var editingIndex: Int?
    var addPlayerAlert: UIAlertController?
    var pendingName: String = ""

    
    var onUpdate: ((Memo) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(memo != nil)
        
        title = memo.title
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let image = UIImage(systemName: "plus.circle.fill")
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(addItemTapped)
        )
    }
    
    @objc func addItemTapped() {
        print("add tapped")
        editingIndex = nil
           pendingName = ""
           selectedPosition = nil
           selectedFoot = nil
        showAddPlayerAlert()
    }
    
    
    func showAddPlayerAlert() {
        // ✅ 추가 모드일 때만 초기화
        
        let alert = UIAlertController(
            title: editingIndex == nil ? "선수 추가" : "선수 수정",
            message: "포지션 / 이름 / 주발을 입력하세요",
            preferredStyle: .alert
        )
        addPlayerAlert = alert
        
        
        // 이름 입력
        alert.addTextField { tf in
            tf.placeholder = "선수 이름"
            tf.text = self.pendingName
        }
        
        // 포지션 선택 버튼
        let positionTitle = selectedPosition?.rawValue ?? "포지션 선택"
        alert.addAction(UIAlertAction(title: positionTitle, style: .default) { _ in
            self.pendingName = alert.textFields?.first?.text ?? ""
            alert.dismiss(animated: false)
            self.showPositionSheet()
        })
        
        // 주발 선택 버튼
        let footTitle = selectedFoot?.rawValue ?? "주발 선택"
        alert.addAction(UIAlertAction(title: footTitle, style: .default) { _ in
            self.pendingName = alert.textFields?.first?.text ?? ""
            alert.dismiss(animated: false)
            self.showFootSheet()
        })
        
        // 저장
        alert.addAction(UIAlertAction(title: "저장", style: .default) { _ in
            self.savePlayer(from: alert)
        })
            
            
         
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true)
       
        
        
    }
    func showPositionSheet() {

        let sheet = UIAlertController(
            title: "포지션 선택",
            message: nil,
            preferredStyle: .actionSheet
            
        )

        for position in Position.allCases {
            sheet.addAction(UIAlertAction(title: position.rawValue, style: .default) { _ in
                self.selectedPosition = position
                self.showAddPlayerAlert()
            })
        }

        sheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(sheet, animated: true)
    }

        
    func showFootSheet() {
        
        let sheet = UIAlertController(
            title: "주발 선택",
            message: nil,
            preferredStyle: .actionSheet
        )
        
        for foot in Foot.allCases {
            sheet.addAction(UIAlertAction(title: foot.rawValue, style: .default) { _ in
                self.selectedFoot = foot
                self.showAddPlayerAlert()
            })
        }
        
        sheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(sheet, animated: true)
    }
   
    func savePlayer(from alert: UIAlertController) {
        guard
            let name = alert.textFields?.first?.text,
            !name.trimmingCharacters(in: .whitespaces).isEmpty,
            let position = selectedPosition,
            let foot = selectedFoot
        else { return }

        let player = Player(position: position, name: name, foot: foot)

        if let index = editingIndex {
            memo.items[index] = player
            editingIndex = nil
        } else {
            memo.items.append(player)
        }

        tableView.reloadData()
        selectedPosition = nil
        selectedFoot = nil
        pendingName = ""
    }

    //
    
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
        let deleteAction = UIContextualAction(style: .destructive,
                                              title: "삭제") { [weak self] _, _, completion in
            guard let self else { return }


            self.memo.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            completion(true)
        }

        // 2️⃣ 수정 액션
        let editAction = UIContextualAction(style: .normal,
                                            title: "편집") { [weak self] _, _, completion in
            guard let self else { return }

            self.editingIndex = indexPath.row
            let player = self.memo.items[indexPath.row]
            self.selectedPosition = player.position
            self.selectedFoot = player.foot
            self.pendingName = player.name
            self.showAddPlayerAlert()
         

            completion(true)
        }

        editAction.backgroundColor = .systemBlue

        let config = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        config.performsFirstActionWithFullSwipe = false // 풀스와이프 방지

        return config
    }
   



    
override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // 화면을 나갈 때 수정된 메모 전달
    onUpdate?(memo)
}

}
