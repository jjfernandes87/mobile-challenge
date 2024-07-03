import Foundation
import DependencyInjector
import LightningInterface

public enum LightningDependencies: RegisterDependenciesProtocol {
    public static func register(container: ContainerRegisterProtocol) {
        container.autoregister(LightningInterface.self, initializer: LightningUseCase.init)
    }
}
