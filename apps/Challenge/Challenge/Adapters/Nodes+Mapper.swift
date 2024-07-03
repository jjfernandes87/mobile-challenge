import Foundation
import LightningInterface

extension Nodes {
    func mapper() -> NodesModel {
        .init(
            publicKey: publicKey,
            alias: alias,
            channels: channels,
            capacityInBTC: converterBTC(),
            firstSeen: dateFormatter(firstSeen),
            updatedAt: dateFormatter(updatedAt),
            city: localized(city),
            country: localized(country)
        )
    }
    
    func converterBTC() -> String {
        let btc = Double(capacity) / 100_000_000
        return String(format: "%.8f BTC", btc)
    }
    
    func dateFormatter(_ date: Date) -> String {
        return date.formatted(date: .abbreviated, time: .omitted)
    }
    
    func localized(_ dict: [String: String]?) -> String {
        return dict?["pt-BR"] ?? dict?["en"] ?? "Unknown"
    }
}

struct NodesModel: Identifiable {
    let id = UUID()
    let publicKey: String
    let alias: String
    let channels: Int
    let capacityInBTC: String
    let firstSeen: String
    let updatedAt: String
    let city: String
    let country: String
}
