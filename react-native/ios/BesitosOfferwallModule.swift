import Foundation
import BesitosOfferwall

@objc(BesitosOfferwall)
class BesitosOfferwallModule: NSObject {

    @objc
    func show(_ options: NSDictionary) {
        guard
            let partnerId = options["partnerId"] as? String,
            let userId = options["userId"] as? String
        else { return }

        let config = OfferwallConfig(
            partnerId: partnerId,
            userId: userId,
            subId: options["subId"] as? String,
            deviceId: options["deviceId"] as? String,
            idfa: options["idfa"] as? String,
            gdfa: options["gdfa"] as? String,
            info: options["info"] as? String,
            hideHeader: options["hideHeader"] as? Bool ?? false,
            hideFooter: options["hideFooter"] as? Bool ?? false
        )

        DispatchQueue.main.async {
            guard let root = UIApplication.shared.windows.first?.rootViewController else { return }
            try? BesitosOfferwall.show(from: root, config: config)
        }
    }

    @objc
    static func requiresMainQueueSetup() -> Bool { false }
}
