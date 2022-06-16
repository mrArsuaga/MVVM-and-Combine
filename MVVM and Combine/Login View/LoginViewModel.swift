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
    
    func validateCredentials(email: String?, password: String?) -> Credentials? {
        guard let email = email,
              let password = password else { return nil }

        return Credentials(mail: email, password: password)
    }
    
    private func executeLogin(_ credentials: Credentials) {
        NetworkService.shared.login(email: credentials.mail, password: credentials.password) { success in
            self.error = success ? nil : "Invalid credentials"
        }
    }
    
    private func setupBinders() {
        $credentials            
            .sink { credentials in
            guard let credentials = credentials else { return }
            self.executeLogin(credentials)
        }.store(in: &cancellables)
    }
}
