//
//  LoginViewModel.swift
//  MVVM and Combine
//
//  Created by Jose Arsuaga on 16/06/22.
//

import Foundation
import Combine

final class LoginViewModel {    
    
    @Published var error: String?
    @Published var credentials: Credentials?
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        setupBinders()
    }
    
    private func setupBinders() {
       $credentials
            .dropFirst()
            .sink { [weak self] credentials in
            guard let credentials = credentials else { return }
            self?.executeLogin(credentials)
            }.store(in: &cancellables)
    }
    
    private func executeLogin(_ credentials: Credentials) {
        NetworkService.shared.login(credentials) { [weak self] success in
            self?.error = success ? nil : "Invalid credentials"
        }
    }
    
    func validateCredentials(email: String?, password: String?) -> Credentials? {
        guard let email = email,
              let password = password else { return nil }
        return Credentials(email: email, password: password)
    }
    
}
