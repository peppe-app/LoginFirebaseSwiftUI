import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Hello 👋")
                }
                .font(.largeTitle)
                .listRowBackground(Color.clear)
            }
        }
    }
}

#Preview {
    HomeView()
}
