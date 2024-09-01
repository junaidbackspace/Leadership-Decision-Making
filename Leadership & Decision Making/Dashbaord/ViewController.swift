import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // Custom gear button
    private let settingsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(systemName: "gearshape.fill"), for: .normal) // Use a system image or your own image
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(openSettings), for: .touchUpInside)
        return button
    }()

    // Logo ImageView
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logoclear") // Replace with your logo image name
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ChessLeaders"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var timer: Timer?
    private let bannerImages = ["banner_first", "banner_second", "banner_third"] // Add your banner image names here

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "detailedviewColor") // Adaptive color
        
        setupViews()
        configureCollectionView()
        startAutoScroll()
        addLessons()
    }

    private func setupViews() {
        // Add the titleStackView with the logo and label
        titleStackView.addArrangedSubview(logoImageView)
        titleStackView.addArrangedSubview(titleLabel)

        view.addSubview(titleStackView)
        view.addSubview(containerView)
        containerView.addSubview(collectionView)
        containerView.addSubview(stackView)
        view.addSubview(settingsButton) // Add settings button to the view

        // Constraints for titleStackView
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            titleStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Constraints for logoImageView (adjust as needed)
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 50),
            logoImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // Constraints for containerView
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
        // Constraints for collectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 200), // Adjust height as needed
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width - 20)
        ])
        
        // Constraints for stackView inside containerView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -50)
        ])

        // Constraints for settingsButton
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            settingsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            settingsButton.widthAnchor.constraint(equalToConstant: 30),
            settingsButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func configureCollectionView() {
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func addLessons() {
        let lesson1 = LessonView(imageName: "thinking", title: "Tactical Thinking")
        let lesson2 = LessonView(imageName: "leadership", title: "Leadership Lessons")
        let lesson3 = LessonView(imageName: "decision", title: "Decision Making")
        
        stackView.addArrangedSubview(lesson1)
        stackView.addArrangedSubview(lesson2)
        stackView.addArrangedSubview(lesson3)
        
        // Add tap handlers
        lesson1.onTap = { [weak self] in
            self?.navigateToDetailViewController(with: "Tactical Thinking",row: 0)
        }
        lesson2.onTap = { [weak self] in
            self?.navigateToDetailViewController(with: "Leadership",row: 1)
        }
        lesson3.onTap = { [weak self] in
            self?.navigateToDetailViewController(with: "Decision Making",row: 2)
        }
    }

    private func navigateToDetailViewController(with text: String , row : Int) {
        let detailVC = DetailViewController()
        detailVC.titlelabel = text
        detailVC.lesson_type = row
        navigationController?.pushViewController(detailVC, animated: true)
    }

    private func startAutoScroll() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            self?.scrollToNextItem()
        }
    }

    private func scrollToNextItem() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let currentIndex = self.collectionView.indexPathsForVisibleItems.first?.row ?? 0
            let nextIndex = (currentIndex + 1) % self.bannerImages.count
            let indexPath = IndexPath(item: nextIndex, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

    // MARK: - Button Actions
    @objc private func openSettings() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCollectionViewCell
        let imageName = bannerImages[indexPath.item]
        cell.imageView.image = UIImage(named: imageName)
        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    deinit {
        timer?.invalidate() // Invalidate the timer when the view controller is deinitialized
    }
}

class BannerCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        backgroundColor = .clear // Ensure cell background is clear
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
