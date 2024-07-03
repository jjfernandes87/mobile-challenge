import XCTest
import DependencyInjector
import NetworkClientInterface
@testable import NetworkClient

final class NetworkDependenciesTests: XCTestCase {
    
    let container = GlobalDependency.container
    
    override func setUp() {
        super.setUp()
        container.removeAll()
        NetworkDependencies.register(container: container)
    }
    
    func test_register() {
        let sut = container.resolve(NetworkClient.self)
        XCTAssertNotNil(sut)
        XCTAssertTrue(sut is NetworkService)
    }
    
}
