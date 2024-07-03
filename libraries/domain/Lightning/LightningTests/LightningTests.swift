import XCTest
import NetworkClientInterface
import LightningInterface
@testable import Lightning

final class LightningUseCaseTests: XCTestCase {
    
    let copyURL = URL(string: "https://mempool.space/api/v1/lightning/nodes/rankings/connectivity")!
    
    func test_validate_urlRequest() {
        let (sut, client) = makeSUT()
        
        sut.fetchNodes { _ in }
        
        XCTAssertEqual(client.urlRequests, [copyURL])
    }
    
    func test_fechNodes_and_returned_error_for_lost_connectivity() {
        let (sut, client) = makeSUT()
        
        assert(sut, completion: .failure(.connectivity) , when: {
            let error = NSError(domain: "any error", code: 0)
            client.completionWith(result: .failure(error))
        })
    }
    
    func test_fechNodes_and_returned_error_for_invalid_data() {
        let (sut, client) = makeSUT()
        
        assert(sut, completion: .failure(.invalidData), when: {
            client.completionWith(statusCode: 400)
        })
    }
    
    func test_fechNodes_and_returned_empty_list() {
        let (sut, client) = makeSUT()
        
        assert(sut, completion: .success([]), when: {
            let data = makeJson([])
            client.completionWith(statusCode: 200, data: data)
        })
    }
    
    func test_fechNodes_and_returned_invalid_data_with_empty_list() {
        let (sut, client) = makeSUT()
        
        assert(sut, completion: .failure(.invalidData)) {
            let data = makeJson([])
            client.completionWith(statusCode: 400, data: data)
        }
    }
    
    func test_fechNodes_and_returned_nodes() {
        let (sut, client) = makeSUT()
        let item1 = makeNodeAndJson()
        
        assert(sut, completion: .success([item1.model])) {
            let data = makeJson([item1.json])
            client.completionWith(statusCode: 200, data: data)
        }
    }
}

private extension LightningUseCaseTests {
    func makeSUT() -> (sut: LightningUseCase, networkSpy: NetworkClientSpy)  {
        let network = NetworkClientSpy()
        let sut = LightningUseCase(networkClient: network)
        return (sut, network)
    }
    
    private func assert(
        _ sut: LightningUseCase,
        completion result: LightningInterface.NodesResult,
        when action: () -> Void,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        
        var expectedResult = [LightningInterface.NodesResult]()
        sut.fetchNodes { expectedResult.append($0) }
        
        action()
        
        XCTAssertEqual(expectedResult, [result], file: file, line: line)
    }
    
    func makeJson(_ items: [[String: Any]]) -> Data {
        let data = try! JSONSerialization.data(withJSONObject: items)
        return data
    }
    
    func makeNodes() -> Nodes {
        Nodes(
            publicKey: "publicKey",
            alias: "alias",
            channels: 2908,
            capacity: 36010516297,
            firstSeen: Date(timeIntervalSince1970: 1720033718),
            updatedAt: Date(timeIntervalSince1970: 1720033718),
            country: ["pt-BR": "EUA"]
        )
    }
    
    func makeNodeAndJson() -> (model: Nodes, json: [String: Any] ) {
        let node = makeNodes()
        let json: [String : Any] = [
            "publicKey": node.publicKey,
            "alias": node.alias,
            "channels": node.channels,
            "capacity": node.capacity,
            "firstSeen": node.firstSeen.timeIntervalSince1970,
            "updatedAt": node.updatedAt.timeIntervalSince1970,
            "country": node.country
        ]
        
        return (node, json)
    }
}
