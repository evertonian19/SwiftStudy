import UIKit

final class EditPlayerViewController: UIViewController {
    
    var onSave: ((Player, Int) -> Void)?
    private var player: Player
    private let index: Int
    
    private let nameTextField = UITextField()
    private let footSegment = UISegmentedControl(items: Foot.allCases.map { $0.rawValue })
    // [추가] 선택된 포지션을 저장할 변수
    private var selectedPosition: Position = .allCases[0]
    private var positionButtons: [UIButton] = []
    
    init(player: Player, index: Int) {
        self.player = player
        self.index = index
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) 사용 안 함")
    }
    // [추가] 버튼들을 담을 수직 스택뷰 생성 함수
    
    
    // [추가] 버튼 클릭 시 상태 업데이트 (색깔 변경 등)
    private func selectPosition(_ pos: Position) {
        self.selectedPosition = pos
        positionButtons.forEach { button in
            let title = button.currentTitle?.trimmingCharacters(in: .whitespaces)
            
            if title == pos.rawValue {
                // [포지션 그룹별 색상]
                let color: UIColor
                switch pos.rawValue {
                case "ST", "LW", "RW": color = .systemRed
                case "CAM", "CM", "RM", "LM", "CDM": color = .systemGreen
                case "CB", "RB", "LB": color = .systemBlue
                case "GK": color = .systemOrange
                default: color = .systemGray
                }
                button.backgroundColor = color
                button.setTitleColor(.white, for: .normal)
            } else {
                button.backgroundColor = .systemGray6
                button.setTitleColor(.label, for: .normal)
                
                
            }
        }
        // 선택된 포지션(예: ST)만 빨간색으로 빛나게 할 수 있어!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = (index == -1) ? "선수 추가" : "선수 수정"
        setupUI()
        bindInitial()
    }

    private func setupUI() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "취소", style: .plain, target: self, action: #selector(tapCancel)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "저장", style: .prominent, target: self, action: #selector(tapSave)
        )

        nameTextField.borderStyle = .roundedRect
        nameTextField.placeholder = "선수 이름"
        
        let positionPicker = makePositionScrollPicker()
        positionPicker.translatesAutoresizingMaskIntoConstraints = false
        positionPicker.heightAnchor.constraint(equalToConstant: 44).isActive = true // 높이를 고정해줘야 스크롤 뷰가 정신을 차려
        // 카드 1: 기본 정보
        let basicInfoStack = UIStackView(arrangedSubviews: [
            positionPicker,
            nameTextField
        ])
        basicInfoStack.axis = .vertical
        basicInfoStack.spacing = 12

        let basicCard = makeCardView(
            title: "Position",
            content: basicInfoStack
        )

        // 카드 2: 옵션
        let optionStack = UIStackView(arrangedSubviews: [
            footSegment
        ])
        optionStack.axis = .vertical
        optionStack.spacing = 12

        let optionCard = makeCardView(
            title: "옵션",
            content: optionStack
        )

        // 전체 레이아웃
        let mainStack = UIStackView(arrangedSubviews: [
            basicCard,
            optionCard
        ])
        mainStack.axis = .vertical
        mainStack.spacing = 16
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    private func makePositionScrollPicker() -> UIView {
        // 1. 스크롤 뷰 생성 (옆으로 미는 틀)
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false // 스크롤바는 안 보이게 깔끔하게!
        
        // 2. 스택 뷰 생성 (버튼들을 가로로 나란히 세워줄 줄자)
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8 // 버튼 사이 간격
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addSubview(stackView)
        
        // 3. 스택 뷰가 스크롤 뷰 안에서 꽉 차게 고정 (이게 중요해!)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
        // 4. 모든 포지션을 돌면서 버튼 만들기
        Position.allCases.forEach { pos in
            let button = UIButton(type: .custom) // 우리가 직접 색칠할 거라 .custom!
            button.setTitle("  \(pos.rawValue)  ", for: .normal) // 양옆에 공백을 줘야 칩 모양이 예뻐
            button.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
            button.layer.cornerRadius = 12
            button.backgroundColor = .systemGray6
            button.setTitleColor(.label, for: .normal)
            
            // 누르면 이름표를 알려주는 숙제 부여!
            button.addAction(UIAction { [weak self] _ in
                self?.selectPosition(pos)
            }, for: .touchUpInside)
            
            positionButtons.append(button) // 바구니에 담기
            stackView.addArrangedSubview(button)
        }
        
        return scrollView
    }


    private func bindInitial() {
        nameTextField.text = player.name
        selectPosition(player.position)
    }

    @objc private func tapCancel() {
        dismiss(animated: true)
    }

    @objc private func tapSave() {
        let name = (nameTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        guard !name.isEmpty else { return }

        
        let foot = Foot.allCases[max(footSegment.selectedSegmentIndex, 0)]
        // [추가] 이제 세그먼트 번호가 아니라, 우리가 저장해둔 'selectedPosition'을 그대로 사용!
        let updated = Player(position: selectedPosition, name: name, foot: foot)

        onSave?(updated, index)
        dismiss(animated: true)
    }
    private func makeCardView(title: String, content: UIView) -> UIView {
        let container = UIView()
        container.backgroundColor = .secondarySystemBackground
        container.layer.cornerRadius = 16

        let titleLabel = UILabel()

            titleLabel.text = title
            // [추가] 너비가 좁아져도 글자가 짤리지 않고 버티게 함 (Priority 설정)
            titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
            titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .secondaryLabel

        let stack = UIStackView(arrangedSubviews: [titleLabel, content])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: container.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            stack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
        ])

        return container
    }

}

