//
//  AuthorizationViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 12.03.23.
//

import UIKit
import FirebaseAuth

protocol AuthorizationViewControllerDelegate: AnyObject {
    func authWasComplited()
}

class AuthorizationViewController: UIViewController {

    weak var delegate: AuthorizationViewControllerDelegate?
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func enterButtonWasPressed(_ sender: Any) {
        guard let email = emailTextField.text, !email.isEmpty, let password = passwordTextField.text, !password.isEmpty else { return }
        Auth.auth().signIn(withEmail: email , password: password){ result, error in
            
            guard error == nil else {
                
                let alertView = UIAlertController(title: "Attention", message: error!.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default)
                
                alertView.addAction(okButton)
                self.present(alertView, animated: true, completion: nil)
                
            //    print(error!.localizedDescription) // нужно выводить для пользователя
                return }
            self.delegate?.authWasComplited()
        }
    }

    @IBAction func navigateToRegistrationButtonWasPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let registrationVC = storyboard.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
     /*   registrationVC.registrationComplited = { [weak self] in
            self?.delegate?.authWasComplited()
        }
     */
        registrationVC.delegate = self
        navigationController?.pushViewController(registrationVC, animated: true)
    }
}

extension AuthorizationViewController: RegistrationViewControllerDelegate {
    func registrationWasComplited() {
        delegate?.authWasComplited()
    }
}


