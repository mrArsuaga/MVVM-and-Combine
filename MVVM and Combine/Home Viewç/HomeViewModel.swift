//
//  HomeViewModel.swift
//  MVVM and Combine
//
//  Created by Jose Arsuaga on 16/06/22.
//

import Foundation
import Combine

final class HomeViewModel {
    @Published var message: String = ""
    
    func createWelcomeMessage() {
        guard let user = NetworkService.shared.getUser() else { return }
        message = "\(user.firstName) \(user.lastName)"
    }
    
    
}
