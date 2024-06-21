import SwiftUI

struct SettingsView: View {
    
    @Environment(AuthManager.self) var authManager
    
    var body: some View {
        NavigationStack {
            List {
                Button("Logout", role: .destructive) {
                    Task {
                        try? await authManager.logout()
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
        .environment(AuthManager.demo)
}
