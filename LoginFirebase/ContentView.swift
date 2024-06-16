import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem { Text("Home") }
            
            SettingsView()
                .tabItem { Text("Settings") }
        }
    }
}

#Preview {
    ContentView()
}
