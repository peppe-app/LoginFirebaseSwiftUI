import SwiftUI

@Observable
final class LoginViewModel {
    var email: String = ""
    var password: String = ""
    
    var canLogin: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    func login() {
        guard canLogin else { return }
    }
}

struct LoginView: View {
    
    @State private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Email", text: $viewModel.email)
                    SecureField("Password", text: $viewModel.password)
                }
                
                Section {
                    Button("Login") {
                        viewModel.login()
                    }
                    .disabled(!viewModel.canLogin)
                } footer: {
                    NavigationLink {
                        SignupView()
                    } label: {
                        Text("Or create an account")
                    }
                    .font(.subheadline)
                }
            }
            .navigationTitle("Login")
        }
    }
}

#Preview {
    LoginView()
}
