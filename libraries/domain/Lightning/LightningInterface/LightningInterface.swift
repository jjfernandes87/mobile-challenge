import Foundation

public enum NodesError: Error {
    case invalidURL
    case connectivity
    case invalidData
}

/**
Sample: {
 "publicKey": "03864ef025fde8fb587d989186ce6a4a186895ee44a926bfc370e2c366597a3f8f",
 "alias": "ACINQ",
 "channels": 2908,
 "capacity": 36010516297,
 "firstSeen": 1522941222,
 "updatedAt": 1661274935,
 "city": { // or null
    "de": "Vancouver",
    "en": "Vancouver",
    "es": "Vancouver",
    "fr": "Vancouver",
    "ja": "バンクーバー市",
    "pt-BR": "Vancôver",
    "ru": "Ванкувер"
 }
 "country": {
    "de": "Vereinigte Staaten",
    "en": "United States",
    "es": "Estados Unidos",
    "fr": "États Unis",
    "ja": "アメリカ",
    "pt-BR": "EUA",
    "ru": "США",
    "zh-CN": "美国"
 }
}
**/

public struct Nodes: Equatable, Codable {
    public let publicKey: String
    public let alias: String
    public let channels: Int
    public let capacity: Int
    public let firstSeen: Int
    public let updatedAt: Int
    public let city: [String: String]?
    public let country: [String: String]
    
    public init(
        publicKey: String,
        alias: String,
        channels: Int,
        capacity: Int,
        firstSeen: Int,
        updatedAt: Int,
        city: [String: String]? = nil,
        country: [String: String]
    ) {
        self.publicKey = publicKey
        self.alias = alias
        self.channels = channels
        self.capacity = capacity
        self.firstSeen = firstSeen
        self.updatedAt = updatedAt
        self.city = city
        self.country = country
    }
    
    public static func == (lhs: Nodes, rhs: Nodes) -> Bool {
        return lhs.publicKey == rhs.publicKey
    }
}

public protocol LightningInterface {
    typealias NodesResult = Result<[Nodes], NodesError>
    func fetchNodes(completion: @escaping (NodesResult) -> Void)
}
