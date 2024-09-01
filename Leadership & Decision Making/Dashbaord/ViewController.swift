import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
    private let bannerImages = ["banner", "banner", "banner"] // Add your banner image names here
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemGray6
        
        setupViews()
        configureCollectionView()
        startAutoScroll()
        addLessons()
    }
    
    private func setupViews() {
        view.addSubview(containerView)
        containerView.addSubview(collectionView)
        containerView.addSubview(stackView)
        
        // Constraints for containerView
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
        // Constraints for collectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 240) // Adjust height as needed
        ])
        
        // Constraints for stackView inside containerView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -50)
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
        let lesson4 = LessonView(imageName: "lesson4", title: "Sacrifices for Greater Gain")
        let lesson5 = LessonView(imageName: "lesson5", title: "Endgame Strategy")
        
        stackView.addArrangedSubview(lesson1)
        stackView.addArrangedSubview(lesson2)
        stackView.addArrangedSubview(lesson3)
        //stackView.addArrangedSubview(lesson4)
        //stackView.addArrangedSubview(lesson5)
        
        // Add tap handlers
        lesson1.onTap = { [weak self] in
            self?.navigateToDetailViewController(with: "Beginner", imageName: "thinking")
        }
        lesson2.onTap = { [weak self] in
            self?.navigateToDetailViewController(with: "Beginner", imageName: "thinking")
        }
        lesson3.onTap = { [weak self] in
            self?.navigateToDetailViewController(with: "Beginner", imageName: "thinking")
        }
        //lesson4.onTap = { [weak self] in
        //    self?.navigateToDetailViewController(with: lesson4.label.text ?? "Unknown", imageName: lesson4.imageView.image?.accessibilityIdentifier ?? "Unknown")
        //}
        //lesson5.onTap = { [weak self] in
        //    self?.navigateToDetailViewController(with: lesson5.label.text ?? "Unknown", imageName: lesson5.imageView.image?.accessibilityIdentifier ?? "Unknown")
        //}
    }
    
    private func navigateToDetailViewController(with text: String, imageName: String) {
        print("navigating...")
        let detailVC = DetailViewController()
        detailVC.data = [(text: text, imageName: imageName)] // Set appropriate background color if needed
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func startAutoScroll() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] _ in
            self?.scrollToNextItem()
        }
    }
    
    private func scrollToNextItem() {
        let currentIndex = collectionView.indexPathsForVisibleItems.first?.row ?? 0
        let nextIndex = (currentIndex + 1) % bannerImages.count
        let indexPath = IndexPath(item: nextIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
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
}

class BannerCollectionViewCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
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
