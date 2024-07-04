import XCTest
import Lightning
import LightningInterface
import DependencyInjector
@testable import Challenge

final class ChallengeViewModelTests: XCTestCase {
    
    let container = GlobalDependency.container
    
    override func setUp() {
        super.setUp()
        container.removeAll()
        LightningDependencies.registerDummy(container: container)
    }
    
    func testFetchNodesSuccess() throws {
        let (sut, spy) = makeSUT()
        
        spy.completionWith(result: .success([]))
        sut.fetchNodes()
        
        let expectation = XCTestExpectation(description: "Fetch nodes")
        DispatchQueue.main.async {
            XCTAssertTrue(sut.isLoading)
            XCTAssertNil(sut.errorMessage)
            XCTAssertEqual(sut.nodes.count, 0)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSortNodesAscending() throws {
        let (sut, spy) = makeSUT()
        let date = Date(timeIntervalSince1970: 1720033718)
        let nodeOne = Nodes(publicKey: "publicKey", alias: "alias", channels: 1, capacity: 1000, firstSeen: date, updatedAt: date)
        let nodeTwo = Nodes(publicKey: "publicKey", alias: "alias", channels: 2, capacity: 1000, firstSeen: date, updatedAt: date)
        
        spy.completionWith(result: .success([nodeOne, nodeTwo]))
        sut.fetchNodes()
        
        let expectation = XCTestExpectation(description: "Sort nodes ascending")
        DispatchQueue.main.async {
            let initialNodes = sut.nodes
            sut.sortNodes(ascending: true)
            let sortedNodes = sut.nodes
            
            XCTAssertTrue(sortedNodes.first?.channels ?? 0 <= sortedNodes.last?.channels ?? 0)
            XCTAssertEqual(initialNodes.count, sortedNodes.count)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSortNodesDescending() throws {
        let (sut, spy) = makeSUT()
        let date = Date(timeIntervalSince1970: 1720033718)
        let nodeOne = Nodes(publicKey: "publicKey", alias: "alias", channels: 1, capacity: 1000, firstSeen: date, updatedAt: date)
        let nodeTwo = Nodes(publicKey: "publicKey", alias: "alias", channels: 2, capacity: 1000, firstSeen: date, updatedAt: date)
        
        spy.completionWith(result: .success([nodeOne, nodeTwo]))
        sut.fetchNodes()
        
        let expectation = XCTestExpectation(description: "Sort nodes descending")
        DispatchQueue.main.async {
            let initialNodes = sut.nodes
            sut.sortNodes(ascending: false)
            let sortedNodes = sut.nodes
            
            XCTAssertTrue(sortedNodes.first?.channels ?? 0 >= sortedNodes.last?.channels ?? 0)
            XCTAssertEqual(initialNodes.count, sortedNodes.count)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}

private extension ChallengeViewModelTests {
    func makeSUT() -> (sut: ChallengeViewModel, useCaseSpy: LightningUseCaseSpy) {
        let sut = ChallengeViewModel()
        let useCaseSpy = GlobalDependency.container.resolveDependency(LightningInterface.self) as! LightningUseCaseSpy
        return (sut, useCaseSpy)
    }
}


