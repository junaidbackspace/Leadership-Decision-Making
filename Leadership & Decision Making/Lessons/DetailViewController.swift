import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none

        return tableView
    }()
    
    private let headingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIColor(named: "LessonLabelColor") // Adaptive color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var images = ["beginner", "inter", "expert"]
    var labels = ["Beginner level", "Intermediate Level", "Expert Level"]
    private let color: [UIColor] = [.red,.green,.purple]
    var titlelabel: String = "" {
        didSet {
            headingLabel.text = titlelabel
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "detailedviewColor") // Adaptive color
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        // Create the back button
        let backButton = UIButton(type: .custom)
        backButton.setBackgroundImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.setTitle("", for: .normal)
        backButton.tintColor = .black
        backButton.setTitleColor(.black, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Create a container view to hold the back button and heading label
        let containerView = UIView()
        containerView.backgroundColor = UIColor(named: "detailedviewColor") // Adaptive color
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(backButton)
        containerView.addSubview(headingLabel) // Use the class-level headingLabel
        
        // Add constraints for the back button and heading label within the container view
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            backButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 35),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            headingLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 10),
            headingLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            headingLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 0),
            headingLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Add the container view to the view hierarchy and set constraints
        view.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 44) // Adjust as needed
        ])
        
        // Bring the container view to the front to ensure it's visible
        view.bringSubviewToFront(containerView)
        
        // Ensure the navigation bar title is empty to avoid conflicts with headingLabel
        navigationItem.title = ""
    }




    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    

    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "detailedviewColor")
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        let image = images[indexPath.row]
        let level = labels[indexPath.row]
        let colors: [UIColor] = [UIColor.red.withAlphaComponent(0.3), UIColor.green.withAlphaComponent(0.3), UIColor.blue.withAlphaComponent(0.3), UIColor.orange.withAlphaComponent(0.3), UIColor.purple.withAlphaComponent(0.3)]
        let backgroundColor = colors[indexPath.row % colors.count]
        
        cell.configure(with: level, imageName: image, backgroundColor: backgroundColor)
        cell.backgroundColor = UIColor(named: "detailedviewColor")
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PDFReaderViewController()
        vc.titlelabel = labels[indexPath.row]
        vc.bgcolor = color[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

class CustomTableViewCell: UITableViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
       
        return view
    }()
    
    private let customImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: "LessonLabelColor") // Adaptive color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(containerView)
        containerView.addSubview(stack)
        
        // Set selection style to none
          selectionStyle = .none
        stack.addArrangedSubview(customImageView)
        stack.addArrangedSubview(label)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            customImageView.widthAnchor.constraint(equalToConstant: 120),
            customImageView.heightAnchor.constraint(equalToConstant: 60),
            stack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            stack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with text: String, imageName: String, backgroundColor: UIColor) {
        label.text = text
        customImageView.image = UIImage(named: imageName)
        containerView.backgroundColor = backgroundColor
    }
}
