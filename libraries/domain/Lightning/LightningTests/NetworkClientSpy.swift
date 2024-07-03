import Foundation
import NetworkClientInterface

final class NetworkClientSpy: NetworkClient {
    
    private(set) var urlRequests = [URL]()
    private var completionHandler: ((NetworkClientResult) -> Void)?
    
    func request(from url: URL, completion: @escaping (NetworkClientResult) -> Void) {
        urlRequests.append(url)
        completionHandler = completion
    }
    
    func completionWith(result: NetworkClientResult) {
        completionHandler?(result)
    }
    
    func completionWith(statusCode: Int, data: Data = Data()) {
        let response = HTTPURLResponse(url: urlRequests[0], statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        completionHandler?(.success((data, response)))
    }
    
}
