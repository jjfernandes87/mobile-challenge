import SwiftUI

@main
struct ChallengeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ChallengeUI()
        }
    }
}
