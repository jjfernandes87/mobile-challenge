import Foundation
import DependencyInjector
import LightningInterface
import Lightning

extension LightningDependencies {
    public static func registerDummy(container: ContainerRegisterProtocol) {
        container.autoregister(LightningInterface.self, initializer: LightningUseCaseSpy.init).inObjectScope(.weak)
    }
}

final class LightningUseCaseSpy: LightningInterface {
    
    private var completionHandler: ((NodesResult) -> Void)?
    func fetchNodes(completion: @escaping (NodesResult) -> Void) {
        completionHandler = completion
    }
    
    func completionWith(result: NodesResult) {
        completionHandler?(result)
    }
}
