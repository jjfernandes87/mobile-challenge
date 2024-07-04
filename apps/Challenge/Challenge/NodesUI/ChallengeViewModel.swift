import Foundation
import Combine
import DependencyInjector
import LightningInterface

final class ChallengeViewModel: ObservableObject {
    @Published var nodes: [NodesModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private var useCase = LightningWithCombine()
    
    func fetchNodes() {
        isLoading = true
        useCase.fetchNodes()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.isLoading = false
                case .failure(let error):
                    self?.isLoading = false
                    self?.errorMessage = error.message()
                }
            } receiveValue: { [weak self] nodes in
                self?.nodes = nodes
            }
            .store(in: &cancellables)
    }
    
    func sortNodes(ascending: Bool) {
        if ascending {
            nodes.sort { $0.channels < $1.channels }
        } else {
            nodes.sort { $0.channels > $1.channels }
        }
    }
}
