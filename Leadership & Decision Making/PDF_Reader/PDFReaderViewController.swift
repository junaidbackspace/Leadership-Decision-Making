import UIKit
import PDFKit

class PDFReaderViewController: UIViewController {
    
    private let pdfView = PDFView()
    private var pdfDocument: PDFDocument? // Reference to the PDF document
    
    var titlelabel: String? {
        didSet {
            titleLabel.text = titlelabel
        }
    }
    
    var bgcolor: UIColor? {
        didSet {
            if let color = bgcolor {
                view.backgroundColor = color.withAlphaComponent(0.3)
            } else {
                view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            }
        }
    }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "PDF Viewer"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        setupNavigationBar()
        setupPDFView()
        loadPDF()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Release PDF document when the view is about to disappear
        pdfDocument = nil
        pdfView.document = nil
    }
    
    private func setupNavigationBar() {
        view.addSubview(titleLabel)
        view.addSubview(backButton)
    
        // Constraints for the back button
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 35),
            backButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        // Constraints for the title label
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: backButton.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupPDFView() {
        pdfView.autoScales = true
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        
        // Constraints for the PDFView
        NSLayoutConstraint.activate([
            pdfView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            pdfView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pdfView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func loadPDF() {
        // Perform PDF loading on a background thread
        DispatchQueue.global(qos: .userInitiated).async {
            // Load PDF file from the project bundle
            guard let pdfURL = Bundle.main.url(forResource: "sample", withExtension: "pdf") else {
                print("Failed to find PDF file.")
                return
            }
            
            let document = PDFDocument(url: pdfURL)
            
            DispatchQueue.main.async { [weak self] in
                // Update the UI on the main thread
                if let document = document {
                    self?.pdfDocument = document
                    self?.pdfView.document = document
                } else {
                    print("Failed to load PDF document.")
                }
            }
        }
    }
    
    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    deinit {
        // Cleanup when the view controller is deallocated
        pdfDocument = nil
        pdfView.document = nil
    }
}
