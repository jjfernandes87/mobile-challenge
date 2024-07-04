import DependencyInjector
import NetworkClient
import Lightning
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        loadDependencies()
        return true
    }
    
    private func loadDependencies() {
        let container = GlobalDependency.container
        NetworkDependencies.register(container: container)
        LightningDependencies.register(container: container)
    }
}
