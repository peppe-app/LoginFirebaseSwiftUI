import Foundation

@Observable
final class AuthManager {
    
    enum State: Equatable {
        case loading
        case authenticated(uid: String)
        case loggedOut
    }
    
    private(set) var state: State = .loading
    
    private var provider: AuthProvider?
    
    func setup(provider: some AuthProvider) {
        self.provider = provider
    }
    
    func refreshAuth() async throws {
        guard let provider else { return }

        guard let cachedAuth = try await provider.fetchCurrentAuth() else {
            state = .loggedOut
            return
        }
        
        state = .authenticated(uid: cachedAuth.userId)
    }
    
    func signIn(email: String, password: String) async throws {
        guard let provider else { return }
        let result = try await provider.signIn(email: email, password: password)
        state = .authenticated(uid: result.userId)
    }
    
    func signup(email: String, password: String) async throws {
        guard let provider else { return }
        let result = try await provider.signUp(email: email, password: password)
        state = .authenticated(uid: result.userId)
    }
    
    func logout() async throws {
        guard let provider else { return }
        try await provider.logout()
        state = .loggedOut
    }
}

// MARK: Testing

extension AuthManager {
    static var demo: AuthManager {
        let auth = AuthManager()
        auth.setup(provider: DemoAuthProvider())
        return auth
    }
}
