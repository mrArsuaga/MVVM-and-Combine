//
//  HomeViewController.swift
//  MVVM and Combine
//
//  Created by Jose Arsuaga on 16/06/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    @IBOutlet private weak var welcomeLabelAssign: UILabel!
    @IBOutlet private weak var welcomeLabel: UILabel!
    let viewModel = HomeViewModel()
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinders()
        viewModel.createWelcomeMessage()
        // Do any additional setup after loading the view.
    }
    
    func setupBinders() {
        viewModel
            .$message
            .dropFirst()
            .map({ message in
                "Hello \(message)"
            })
            .sink { message in
                self.welcomeLabel.text = message
            }.store(in: &cancellables)
        
        viewModel
            .$message
            .dropFirst()
            .map({ message in
                "Assign \(message)"
            })
            .map { "Shorthand Argument: \n \($0)" }
            .assign(to: \.text, on: welcomeLabelAssign)
            .store(in: &cancellables)
    }
}
