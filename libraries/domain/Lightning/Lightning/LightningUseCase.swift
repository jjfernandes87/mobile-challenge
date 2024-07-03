import Foundation
import LightningInterface
import NetworkClientInterface

final class LightningUseCase {
    
    private let networkClient: NetworkClient
    private let baseURL = URL(string: "https://mempool.space/api/v1/lightning/nodes/rankings/connectivity")
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    static func successfullyValidation(_ data: Data, response: HTTPURLResponse) -> NodesResult {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        guard response.statusCode == 200, let nodes = try? decoder.decode([Nodes].self, from: data) else {
            return  .failure(.invalidData)
        }
        return .success(nodes)
    }
}

extension LightningUseCase: LightningInterface {
    func fetchNodes(completion: @escaping (NodesResult) -> Void) {
        guard let url = baseURL else {
            completion(.failure(.invalidURL))
            return
        }
        
        networkClient.request(from: url) { result in
            switch result {
            case let .success((data, response)): 
                completion(LightningUseCase.successfullyValidation(data, response: response))
            case .failure: 
                completion(.failure(.connectivity))
            }
        }
    }
}
