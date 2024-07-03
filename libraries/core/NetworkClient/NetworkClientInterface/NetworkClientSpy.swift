import Foundation

public final class NetworkClientSpy: NetworkClient {
    
    public private(set) var urlRequests = [URL]()
    private var completionHandler: ((NetworkClientResult) -> Void)?
    
    public init() {}
    
    public func request(from url: URL, completion: @escaping (NetworkClientResult) -> Void) {
        urlRequests.append(url)
        completionHandler = completion
    }
    
    public func completionWith(result: NetworkClientResult) {
        completionHandler?(result)
    }
    
    public func completionWith(statusCode: Int, data: Data = Data()) {
        let response = HTTPURLResponse(url: urlRequests[0], statusCode: statusCode, httpVersion: nil, headerFields: nil)!
        completionHandler?(.success((data, response)))
    }
    
}
