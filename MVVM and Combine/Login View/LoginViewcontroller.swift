//
//  LoginViewController.swift
//  MVVM and Combine
//
//  Created by Jose Arsuaga on 16/06/22.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    let viewModel = LoginViewModel()
    var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinders()
    }
    
    private func setupBinders() {
        viewModel
            .$error
            .dropFirst()
            .sink { [weak self] error in
            if error == nil {
                self?.goToHomeViewController()
            } else {
                print(error ?? "")
            }
        }.store(in: &cancellables)
    }
    
    private func goToHomeViewController() {
        guard let homeViewController = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController else { return }
        present(homeViewController, animated: true, completion: nil)
    }
    
    @IBAction func loginButtonTapped() {
        guard let credentials = viewModel.validateCredentials(email: emailTextField.text,
                                                              password: passwordTextField.text) else { return }
        viewModel.credentials = credentials
    }


}

