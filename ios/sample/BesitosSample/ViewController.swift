import UIKit
import BesitosOfferwall

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 1)
        setupUI()
    }

    private lazy var titleLabel: UILabel = {
        let l = UILabel()
        l.text = "Besitos SDK"
        l.font = UIFont.boldSystemFont(ofSize: 28)
        l.textColor = UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
        l.textAlignment = .center
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()

    private lazy var userIdField: UITextField = makeField(placeholder: "User ID (required)", text: "user_123")
    private lazy var subIdField: UITextField = makeField(placeholder: "Sub ID")
    private lazy var deviceIdField: UITextField = makeField(placeholder: "Device ID")
    private lazy var infoField: UITextField = makeField(placeholder: "Extra Info")

    private lazy var launchButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("LAUNCH WITH CONFIG", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        b.backgroundColor = UIColor(red: 239/255, green: 0, blue: 0, alpha: 1)
        b.layer.cornerRadius = 14
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(launchTapped), for: .touchUpInside)
        return b
    }()

    private func setupUI() {
        let stack = UIStackView(arrangedSubviews: [
            titleLabel, userIdField, subIdField, deviceIdField, infoField, launchButton
        ])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            launchButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }

    private func makeField(placeholder: String, text: String? = nil) -> UITextField {
        let f = UITextField()
        f.placeholder = placeholder
        f.text = text
        f.borderStyle = .roundedRect
        f.font = UIFont.systemFont(ofSize: 15)
        f.translatesAutoresizingMaskIntoConstraints = false
        f.heightAnchor.constraint(equalToConstant: 44).isActive = true
        return f
    }

    @objc private func launchTapped() {
        let userId = userIdField.text?.trimmingCharacters(in: .whitespaces) ?? ""
        guard !userId.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "User ID is required", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }

        let config = OfferwallConfig(
            partnerId: "PARTNER_ID_HERE",
            userId: userId,
            subId: subIdField.text?.isEmpty == false ? subIdField.text : nil,
            deviceId: deviceIdField.text?.isEmpty == false ? deviceIdField.text : nil,
            info: infoField.text?.isEmpty == false ? infoField.text : nil,
            hideHeader: true,
            hideFooter: true
        )

        do {
            try BesitosOfferwall.show(from: self, config: config)
        } catch {
            let alert = UIAlertController(title: "SDK Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
}
