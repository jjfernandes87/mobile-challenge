import Foundation
import DependencyInjector
import NetworkClientInterface

public enum NetworkDependencies: RegisterDependenciesProtocol {
    public static func register(container: ContainerRegisterProtocol) {
        container.register(NetworkClient.self) { _ in
            let session = URLSession(configuration: .ephemeral)
            return NetworkService(session: session)
        }
    }
}
