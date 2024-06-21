import SwiftUI

@Observable
final class LoginViewModel {
    var email: String = ""
    var password: String = ""
    
    private(set) var isLoading = false
    
    private var authManager: AuthManager?
    
    var canLogin: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    func setup(authManager auth: AuthManager) {
        authManager = auth
    }
    
    func login() {
        guard canLogin else { return }
        guard let authManager else { return }
        
        isLoading.toggle()
        
        Task {
            defer {
                isLoading.toggle()
            }
            
            do {
                _ = try await authManager.signIn(email: email, password: password)
            } catch {
                
            }
        }
    }
}

struct LoginView: View {
    
    @Environment(AuthManager.self) private var auth
    @State private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                    SecureField("Password", text: $viewModel.password)
                }
                
                Section {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Button("Login") {
                            viewModel.login()
                        }
                        .disabled(!viewModel.canLogin)
                    }
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
            .onAppear {
                viewModel.setup(authManager: auth)
            }
        }
    }
}

#Preview {
    LoginView()
        .environment(AuthManager.demo)
}
