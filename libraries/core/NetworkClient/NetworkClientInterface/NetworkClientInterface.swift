import Foundation

public protocol NetworkClient {
    typealias NetworkClientResult = Result<(Data, HTTPURLResponse), Error>
    func request(from url: URL, completion: @escaping (NetworkClientResult) -> Void)
}
