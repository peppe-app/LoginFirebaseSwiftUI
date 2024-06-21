import SwiftUI

@Observable
final class SignupViewModel {
    var email: String = ""
    var password: String = ""
    var rePassword: String = ""
    
    private(set) var isLoading = false
    
    private var authManager: AuthManager?
    
    var canSignup: Bool {
        !email.isEmpty
        && !password.isEmpty
        && !rePassword.isEmpty
        && password == rePassword
    }
    
    func setup(authManager auth: some AuthManager) {
        authManager = auth
    }
    
    func signup() {
        guard canSignup else { return }
        guard let authManager else { return }
        
        isLoading.toggle()
        
        Task {
            defer {
                isLoading.toggle()
            }
            
            do {
                let _ = try await authManager.signup(email: email, password: password)
            } catch {
                
            }
        }
    }
}

struct SignupView: View {
    
    @Environment(AuthManager.self) var auth
    @State private var viewModel = SignupViewModel()
    
    var body: some View {
        Form {
            Section {
                TextField("Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $viewModel.password)
                SecureField("Repeat Password", text: $viewModel.rePassword)
            }
            
            Section {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Button("Signup") {
                        viewModel.signup()
                    }
                    .disabled(!viewModel.canSignup)
                }
            }
        }
        .navigationTitle("Signup")
        .onAppear {
            viewModel.setup(authManager: auth)
        }
    }
}

#Preview {
    NavigationStack {
        SignupView()
            .environment(AuthManager.demo)
    }
}
