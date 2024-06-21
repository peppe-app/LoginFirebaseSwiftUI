import SwiftUI

@Observable
final class ContentViewModel {
    
    private var authManager: AuthManager?
    
    var state: AuthManager.State? {
        authManager?.state
    }
    
    func setup(authManager: AuthManager) {
        self.authManager = authManager
    }
    
    func refreshAuth() {
        guard let authManager else { return }
        Task {
            do {
                try await authManager.refreshAuth()
            } catch {
                
            }
        }
    }
}

struct ContentView: View {
    
    @Environment(AuthManager.self) private var auth
    
    @State private var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading, .none:
                ProgressView()
                    .onAppear {
                        viewModel.setup(authManager: auth)
                        viewModel.refreshAuth()
                    }
                
            case .authenticated:
                loggedInView
                
            case .loggedOut:
                LoginView()
            }
        }
    }
    
    private var loggedInView: some View {
        TabView {
            HomeView()
                .tabItem { Label("Home", systemImage: "house") }
            
            SettingsView()
                .tabItem { Label("Settings", systemImage: "ellipsis") }
        }
        
    }
}

#Preview {
    ContentView()
        .environment(AuthManager.demo)
}
