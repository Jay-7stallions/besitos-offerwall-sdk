import UIKit

public enum BesitosOfferwallError: Error {
    case invalidConfig(String)
    case urlBuildFailed
}

public class BesitosOfferwall {

    public static func show(from viewController: UIViewController, config: OfferwallConfig) throws {
        switch ValidationUtil.validate(config) {
        case .invalid(let reason):
            throw BesitosOfferwallError.invalidConfig(reason)
        case .valid:
            break
        }

        guard let url = UrlBuilder.build(config: config) else {
            throw BesitosOfferwallError.urlBuildFailed
        }

        let offerwallVC = OfferwallViewController(url: url)
        viewController.present(offerwallVC, animated: true)
    }
}
