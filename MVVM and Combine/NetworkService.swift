//
//  NetworkService.swift
//  MVVM and Combine
//
//  Created by Jose Arsuaga on 16/06/22.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    var user: User?
    
    private init() { }
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            if email.elementsEqual("test@test.com") && password.elementsEqual("password") {
                self?.user = User(firstName: "Jose", lastName: "Arsuaga")
                completion(true)
            } else {
                self?.user = nil
                completion(false)
            }
        }
    }
}
