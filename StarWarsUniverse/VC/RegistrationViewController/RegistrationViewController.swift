//
//  RegistrationViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 12.03.23.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

protocol RegistrationViewControllerDelegate: AnyObject {
    func registrationWasComplited()
}

class RegistrationViewController: UIViewController {
    
  //  var registrationComplited: (() -> Void)?
    
    weak var delegate: RegistrationViewControllerDelegate?
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerButtonWasPressed(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            guard error == nil else {
                let alertView = UIAlertController(title: "Attention", message: error!.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default)
                
                alertView.addAction(okButton)
                self.present(alertView, animated: true, completion: nil)
                
               // print(error!.localizedDescription) // нужно выводить для пользователя
                return }
            self.createUserAtFireStore(email: email)
            self.delegate?.registrationWasComplited()
         
       //     guard let closure = self.registrationComplited else { return }
       //     closure()
        }
    }
    
    private func createUserAtFireStore(email: String) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        APIManager.shared.createUser(userID: userID, email: email)
    }
}

