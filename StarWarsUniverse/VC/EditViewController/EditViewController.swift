//
//  EditViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 19.03.23.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

class EditViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    private func setUserInformation(profile: ProfileModel) {
        nameTextField.text = profile.name
        surnameTextField.text = profile.surname
        ageTextField.text = profile.age
    }

    @IBAction func saveEditingButton(_ sender: Any) {
        guard let email = Auth.auth().currentUser?.email else { return }
        var profile = ProfileModel(email: email, name: nil, surname: nil, age: nil)
        if let name = nameTextField.text,!name.isEmpty {
            profile.name = name
        }
        if let surname = surnameTextField.text, !surname.isEmpty {
            profile.surname = surname
        }
        if let age = ageTextField.text,!age.isEmpty {
            profile.age = age
        }
        guard let userId = Auth.auth().currentUser?.uid else { return }
        APIManager.shared.setNewProfileInfo(userId: userId, newProfile: profile) { result in
            switch result {
                case.success:
                    self.navigationController?.popViewController(animated: true)
                case.failure(let error):
                    let alertView = UIAlertController(title: "Attention", message: error.localizedDescription, preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "OK", style: .default)
                    
                    alertView.addAction(okButton)
                    self.present(alertView, animated: true, completion: nil)
                //    print(error.localizedDescription) // alert
            }
        }
    }
    

}
