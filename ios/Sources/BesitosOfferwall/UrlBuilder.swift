import Foundation

struct UrlBuilder {
    private static let baseUrl = "https://wall.besitos.ai/v1"

    static func build(config: OfferwallConfig) -> URL? {
        var components = URLComponents(string: "\(baseUrl)/\(encode(config.partnerId))/offers")
        var items: [URLQueryItem] = []

        items.append(URLQueryItem(name: "userid", value: config.userId))

        if let subId = config.subId, !subId.isEmpty {
            items.append(URLQueryItem(name: "subid", value: subId))
        }
        if let deviceId = config.deviceId, !deviceId.isEmpty {
            items.append(URLQueryItem(name: "device_id", value: deviceId))
        }
        if let idfa = config.idfa, !idfa.isEmpty {
            items.append(URLQueryItem(name: "idfa", value: idfa))
        }
        if let gdfa = config.gdfa, !gdfa.isEmpty {
            items.append(URLQueryItem(name: "gdfa", value: gdfa))
        }
        if let info = config.info, !info.isEmpty {
            items.append(URLQueryItem(name: "info", value: info))
        }
        if config.hideHeader {
            items.append(URLQueryItem(name: "hide_header", value: "1"))
        }
        if config.hideFooter {
            items.append(URLQueryItem(name: "hide_footer", value: "1"))
        }

        components?.queryItems = items
        return components?.url
    }

    private static func encode(_ value: String) -> String {
        value.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? value
    }
}
