import XCTest
import DependencyInjector
import LightningInterface
import NetworkClientInterface
@testable import Lightning

final class LightningDependenciesTests: XCTestCase {
    
    let container = GlobalDependency.container
    
    override func setUp() {
        super.setUp()
        container.removeAll()
        LightningDependencies.register(container: container)
        NetworkDependencies.registerDummy(container: container)
    }
    
    func test_register() {
        let sut = container.resolve(LightningInterface.self)
        XCTAssertNotNil(sut)
        XCTAssertTrue(sut is LightningUseCase)
    }
    
}

private enum NetworkDependencies: RegisterDependenciesProtocol {
    static func register(container: any ContainerRegisterProtocol) {}
    static func registerDummy(container: ContainerRegisterProtocol) {
        container.autoregister(NetworkClient.self, initializer: NetworkClientSpy.init)
    }
}
