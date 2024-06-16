import SwiftUI

@Observable
final class SignupViewModel {
    var email: String = ""
    var password: String = ""
    var rePassword: String = ""
    
    var canSignup: Bool {
        !email.isEmpty
        && !password.isEmpty
        && !rePassword.isEmpty
        && password == rePassword
    }
    
    func login() {
        guard canSignup else { return }
    }
}

struct SignupView: View {
    
    @State private var viewModel = SignupViewModel()
    
    var body: some View {
        Form {
            Section {
                TextField("Email", text: $viewModel.email)
                SecureField("Password", text: $viewModel.password)
                SecureField("Repeat Password", text: $viewModel.rePassword)
            }
            
            Section {
                Button("Signup") {
                    viewModel.login()
                }
                .disabled(!viewModel.canSignup)
            }
        }
        .navigationTitle("Signup")
    }
}

#Preview {
    NavigationStack {
        SignupView()
    }
}
