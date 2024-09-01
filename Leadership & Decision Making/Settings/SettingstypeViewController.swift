import UIKit

class SettingstypeViewController: UIViewController {
    var titlelabel: String?
    
    private let options = ["Privacy Policy", "Terms and Conditions", "About App"]

    private let contents = [
        "Privacy Policy": """
        Your privacy is of utmost importance to us at Chess Leaders. This Privacy Policy outlines how we collect, use, and protect your personal information when you use our mobile application. By using our app, you consent to the data practices described in this policy.

        1. Information Collection:
           We collect personal information such as your name, email address, and contact details when you register or interact with our app. We also collect non-personal information including device data and usage statistics to improve our services.

        2. Use of Information:
           The information we gather is used to provide, maintain, and improve our app’s functionality. It helps us understand user preferences, communicate important updates, and enhance user experience. We do not share your personal information with third parties except as necessary to fulfill our services or comply with legal requirements.

        3. Data Security:
           We employ industry-standard security measures to safeguard your data against unauthorized access and misuse. However, please be aware that no method of electronic transmission or storage is completely secure.

        4. Cookies and Tracking:
           Our app uses cookies and similar technologies to track user activity and preferences. You can manage cookie settings through your device preferences.

        5. Changes to Privacy Policy:
           We may update this Privacy Policy periodically. We will notify you of significant changes by posting the revised policy on our app and updating the effective date.

        6. Contact Us:
           If you have any questions or concerns about this Privacy Policy, please contact us at support@chessleaders.com.
        """,
        
        "Terms and Conditions": """
        Welcome to Chess Leaders. These Terms and Conditions govern your use of our mobile application. By accessing or using our app, you agree to abide by these terms. If you do not agree with these terms, please discontinue use of the app.

        1. Acceptance of Terms:
           Your use of the app signifies your acceptance of these Terms and Conditions. We may update these terms at any time, and your continued use constitutes acceptance of any changes.

        2. User Responsibilities:
           You agree to use our app in compliance with applicable laws and regulations. You are responsible for maintaining the confidentiality of your account information and for any activities conducted under your account.

        3. Intellectual Property:
           All content, including text, graphics, and logos, is the property of Chess Leaders or its licensors and is protected by intellectual property laws. Unauthorized use or reproduction of our content is prohibited.

        4. Prohibited Activities:
           You may not use the app for unlawful purposes or engage in any activities that disrupt its functionality or affect other users.

        5. Limitation of Liability:
           Chess Leaders is not liable for any indirect or consequential damages arising from your use of the app or inability to use it.

        6. Termination:
           We reserve the right to terminate or suspend your access to the app if you violate these Terms and Conditions.

        7. Governing Law:
           These terms are governed by the laws of the jurisdiction in which we operate. Any disputes will be resolved in accordance with these laws.

        8. Contact Us:
           For questions or concerns regarding these Terms and Conditions, please contact us at support@chessleaders.com.
        """,
        
        "About App": """
        Chess Leaders is an innovative mobile application aimed at enhancing leadership and decision-making skills through chess strategies. Our app provides engaging lessons and simulations based on chess principles.

        1. Features:
           - Tactical Thinking: Develop strategic thinking skills by analyzing and solving chess-related scenarios.
           - Leadership Lessons: Learn leadership principles inspired by historical chess games and strategies.
           - Decision-Making Simulator: Practice decision-making skills through interactive simulations based on chess tactics.
           - Progress Tracking: Monitor your learning progress and achievements within the app.

        2. Mission:
           Our mission is to use the strategic insights of chess to empower users in their personal and professional lives. We strive to make learning engaging and effective through practical application of chess principles.

        3. Development Team:
           Chess Leaders was developed by a dedicated team of chess enthusiasts and professionals. We are committed to delivering high-quality content and a seamless user experience.

        4. Support and Feedback:
           We value your feedback and are here to assist you. For support or inquiries, please contact us at support@chessleaders.com.

        5. Stay Connected:
           Follow us on social media for updates and news. Connect with us on Twitter, Facebook, and Instagram.

        6. Acknowledgments:
           We appreciate the contributions of chess experts and enthusiasts who have supported the development of Chess Leaders. Your insights have been invaluable.
        """
    ]

    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.07)
        return view
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = titlelabel
        
        setupBackButton()
        setupTitleLabel()
        setupScrollView()
        setupContent()
    }
    
    private func setupBackButton() {
        view.addSubview(backButton)
        
        // Constraints for the back button
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 37),
            backButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupTitleLabel() {
        view.addSubview(titleLabel)
        
        titleLabel.text = titlelabel
        
        // Constraints for the title label
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        // Add contentView to scrollView
        scrollView.addSubview(contentView)
        
        // Constraints for the scrollView
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Constraints for the contentView inside scrollView
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupContent() {
        contentView.addSubview(contentLabel)
        
        // Set attributed text with bold formatting
        let content = contents[titlelabel ?? ""]
        let attributedString = NSMutableAttributedString(string: content!)
        
        // Define bold attributes
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
        ]
        
        // Apply bold attributes to section headers
        let boldRanges = [
            (searchText: "Information Collection:", replacement: "Information Collection:"),
            (searchText: "Use of Information:", replacement: "Use of Information:"),
            (searchText: "Data Security:", replacement: "Data Security:"),
            (searchText: "Cookies and Tracking:", replacement: "Cookies and Tracking:"),
            (searchText: "Changes to Privacy Policy:", replacement: "Changes to Privacy Policy:"),
            (searchText: "Contact Us:", replacement: "Contact Us:"),
            (searchText: "Acceptance of Terms:", replacement: "Acceptance of Terms:"),
            (searchText: "User Responsibilities:", replacement: "User Responsibilities:"),
            (searchText: "Intellectual Property:", replacement: "Intellectual Property:"),
            (searchText: "Prohibited Activities:", replacement: "Prohibited Activities:"),
            (searchText: "Limitation of Liability:", replacement: "Limitation of Liability:"),
            (searchText: "Termination:", replacement: "Termination:"),
            (searchText: "Governing Law:", replacement: "Governing Law:"),
            (searchText: "Contact Us:", replacement: "Contact Us:"),
            (searchText: "Features:", replacement: "Features:"),
            (searchText: "Mission:", replacement: "Mission:"),
            (searchText: "Development Team:", replacement: "Development Team:"),
            (searchText: "Support and Feedback:", replacement: "Support and Feedback:"),
            (searchText: "Stay Connected:", replacement: "Stay Connected:"),
            (searchText: "Acknowledgments:", replacement: "Acknowledgments:")
        ]
        
        for boldRange in boldRanges {
            let range = (content as! NSString).range(of: boldRange.searchText)
            attributedString.addAttributes(boldAttributes, range: range)
        }
        
        contentLabel.attributedText = attributedString
        
        // Constraints for the contentLabel inside contentView
        NSLayoutConstraint.activate([
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Button Action
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
