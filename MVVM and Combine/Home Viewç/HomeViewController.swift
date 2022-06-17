//
//  HomeViewController.swift
//  MVVM and Combine
//
//  Created by Jose Arsuaga on 16/06/22.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    @IBOutlet private weak var welcomeLabel: UILabel!
    @IBOutlet private weak var welcomeLabelAssing: UILabel!
    let viewModel = HomeViewModel()
    var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinders()
        viewModel.getCurrentUser()
        // Do any additional setup after loading the view.
    }
    
    private func setupBinders() {
        viewModel
            .$message
            .map { "Hello \($0)" }
            .sink { message in
            self.welcomeLabel.text = message
            }.store(in: &cancellables)
        
        viewModel
            .$message
            .map { "Hello \($0) assign" }
            .assign(to: \.text, on: welcomeLabelAssing)
            .store(in: &cancellables)
    }
}
