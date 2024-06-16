import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Button("Logout", role: .destructive) {
                    
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
