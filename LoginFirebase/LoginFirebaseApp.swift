import SwiftUI
import FirebaseCore

@main
struct LoginFirebaseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.authProvider, FirebaseAuthProvider())
                .environment({
                    let auth = AuthManager()
                    auth.setup(provider: FirebaseAuthProvider())
                    return auth
                }())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
