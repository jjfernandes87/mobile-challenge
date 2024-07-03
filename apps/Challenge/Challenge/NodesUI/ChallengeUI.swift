import SwiftUI
import Combine

struct ChallengeUI: View {
    @StateObject private var viewModel = ChallengeViewModel()
    @State private var sortOrder: SortOrder = .ascending
    @State private var isRefreshing = false
    
    enum SortOrder {
        case ascending
        case descending
        
        var description: String {
            switch self {
            case .ascending:
                return "Ascending"
            case .descending:
                return "Descending"
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.nodes) { node in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(node.alias).font(.headline)
                            Text("Nodes: \(node.channels)").font(.headline)
                            Text("City: \(node.city)").font(.subheadline)
                            Text("Country: \(node.country)").font(.subheadline)
                            Text("Created at: \(node.firstSeen)").font(.footnote)
                            Text("Updated at: \(node.updatedAt)").font(.footnote)
                        }
                        .padding(.vertical, 10)
                    }
                }
                .refreshable {
                    viewModel.fetchNodes()
                }
                .overlay(
                    GeometryReader { geometry in
                        if isRefreshing {
                            ProgressView()
                                .offset(y: -geometry.size.height / 2)
                        }
                    }
                )
                .onReceive(viewModel.$isLoading) { loading in
                    if !loading {
                        isRefreshing = false
                    }
                }
                
                if viewModel.errorMessage != nil {
                    ErrorView(errorMessage: viewModel.errorMessage ?? "") {
                        viewModel.fetchNodes()
                    }
                }
            }
            .navigationTitle("Nodes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: {
                            sortOrder = .ascending
                            viewModel.sortNodes(ascending: true)
                        }) {
                            Label("Ascending", systemImage: "arrow.up")
                        }
                        Button(action: {
                            sortOrder = .descending
                            viewModel.sortNodes(ascending: false)
                        }) {
                            Label("Descending", systemImage: "arrow.down")
                        }
                    } label: {
                        Label(sortOrder.description, systemImage: "arrow.up.arrow.down")
                    }
                }
            }
            .onAppear {
                viewModel.fetchNodes()
            }
        }
    }
}

#Preview {
    ChallengeUI()
}
