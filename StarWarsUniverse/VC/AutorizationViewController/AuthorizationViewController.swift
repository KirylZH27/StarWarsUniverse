//
//  AuthorizationViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 12.03.23.
//

import UIKit
import FirebaseAuth

class AuthorizationViewController: UIViewController {

    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func enterButtonWasPressed(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
        Auth.auth().signIn(withEmail: email , password: password){ result, error in
            
            guard error == nil else {
                print(error!.localizedDescription) // нужно выводить для пользователя
                return }
        }
    }
    
    
    @IBAction func navigateToRegistrationButtonWasPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let registrationVC = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
           
           present(registrationVC, animated: true)
    }
    
    
}
