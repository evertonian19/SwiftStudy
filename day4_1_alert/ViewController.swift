import UIKit



// ✅ ViewController 클래스 시작
class ViewController: UIViewController,
                      UITableViewDelegate,
                      UITableViewDataSource {
    
    var memoList: [Memo] = [
        Memo(title: "Scout List", items: []),
        Memo(title: "Loan List", items: []),
        Memo(title: "Remove List", items: [])
    ]
    
    // 🔹 IBOutlet은 반드시 클래스 안
    @IBOutlet weak var tableView: UITableView!



    override func viewDidLoad() {
        super.viewDidLoad()

        loadMemos()                // ⭐️ 이 줄이 핵심
        tableView.reloadData()     // 불러온 데이터로 화면 갱신

        tableView.delegate = self
        tableView.dataSource = self

    
    }
    func tableView(_ tableView: UITableView,
                    numberOfRowsInSection section: Int) -> Int {
         return memoList.count
     }
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MemoCell",
            for: indexPath
        )

        cell.textLabel?.text = memoList[indexPath.row].title
        return cell
    }


    

    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {

        guard let vc = storyboard?.instantiateViewController(
            withIdentifier: "SecondViewController"
        ) as? SecondViewController else { return }

        vc.memo = memoList[indexPath.row]

        vc.onUpdate = { [weak self] updatedMemo in
            guard let self = self else { return }
            self.memoList[indexPath.row] = updatedMemo
            self.saveMemos()
            self.tableView.reloadData()
        }

        navigationController?.pushViewController(vc, animated: true)
    }

    // 🔹 저장 함수
    func saveMemos() {
        if let data = try? JSONEncoder().encode(memoList) {
            UserDefaults.standard.set(data, forKey: "memoList")
        }
    }
    func loadMemos() {
        if let data = UserDefaults.standard.data(forKey: "memoList"),
           let savedMemos = try? JSONDecoder().decode([Memo].self, from: data) {
            memoList = savedMemos
        }
    }

}
