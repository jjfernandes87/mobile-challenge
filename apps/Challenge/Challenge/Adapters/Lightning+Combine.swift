import Foundation
import Combine
import DependencyInjector
import LightningInterface

final class LightningWithCombine {
    @Inject private var useCase: LightningInterface
    
    func fetchNodes() -> AnyPublisher<[NodesModel], NodesError> {
        Future { [weak self] promise in
            guard let self else { return }
            self.useCase.fetchNodes { result in
                switch result {
                case .success(let nodes):
                    promise(.success(nodes.map { return $0.mapper() } ))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
