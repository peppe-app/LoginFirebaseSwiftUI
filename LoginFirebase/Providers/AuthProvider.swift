import Foundation
import FirebaseAuth

protocol AuthProvider {
    func signIn(email: String, password: String) async throws -> AuthResult
    func signUp(email: String, password: String) async throws -> AuthResult
    
    func fetchCurrentAuth() async throws -> AuthResult?
    
    func logout() async throws
}

struct AuthResult {
    let userId: String
}

final class FirebaseAuthProvider: AuthProvider {
    
    private let auth = Auth.auth()
        
    func signIn(email: String, password: String) async throws -> AuthResult {
        let result = try await auth.signIn(withEmail: email, password: password)
        return AuthResult(userId: result.user.uid)
    }
    
    func signUp(email: String, password: String) async throws -> AuthResult {
        let result = try await auth.createUser(withEmail: email, password: password)
        return AuthResult(userId: result.user.uid)
    }
    
    func fetchCurrentAuth() async throws -> AuthResult? {
        guard let user = auth.currentUser else {
            return nil
        }
        
        return AuthResult(userId: user.uid)
    }
    
    func logout() async throws {
        try auth.signOut()
    }
    
}

final class DemoAuthProvider: AuthProvider {
    
    func signIn(email: String, password: String) async throws -> AuthResult {
        try! await Task.sleep(for: .seconds(1))
        return AuthResult(userId: UUID().uuidString)
    }
    
    func signUp(email: String, password: String) async throws -> AuthResult {
        try! await Task.sleep(for: .seconds(1))
        return AuthResult(userId: UUID().uuidString)
    }
    
    func fetchCurrentAuth() async throws -> AuthResult? {
        try! await Task.sleep(for: .seconds(1))
        return AuthResult(userId: UUID().uuidString)
    }
    
    func logout() async throws {
        try! await Task.sleep(for: .seconds(1))
    }
    
}

import SwiftUI

private struct AuthProviderEnvironmentKey: EnvironmentKey {
    static let defaultValue: any AuthProvider = DemoAuthProvider()
}

extension EnvironmentValues {
    var authProvider: any AuthProvider {
        get { self[AuthProviderEnvironmentKey.self] }
        set { self[AuthProviderEnvironmentKey.self] = newValue }
    }
}

// Da Xcode 16
//extension EnvironmentValues {
//    @Entry var authProvider: any AuthProvider = DemoAuthProvider()
//}
