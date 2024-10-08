import UIKit

class LessonView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: "LessonLabelColor") // Adaptive color
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Closure to handle tap actions
    var onTap: (() -> Void)?
    
    init(imageName: String, title: String) {
        super.init(frame: .zero)
        setupView(imageName: imageName, title: title)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(imageName: String, title: String) {
        let stackView = UIStackView(arrangedSubviews: [imageView, label])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        imageView.image = UIImage(named: imageName)
        label.text = title
        
        // Constraints for imageView
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // Constraints for the stack view
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
        
        // Style the LessonView
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.cgColor
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.9
        layer.shadowOffset = CGSize(width: 5, height: 4)
        layer.shadowRadius = 10
        clipsToBounds = true
        
        // Optional: Set shadow path for better performance
               let shadowPath = UIBezierPath(rect: self.bounds)
               self.layer.shadowPath = shadowPath.cgPath
    }
    
    @objc private func didTap() {
        onTap?() // Call the closure when the view is tapped
    }
}
