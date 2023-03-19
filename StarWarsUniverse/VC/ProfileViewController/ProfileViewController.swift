//
//  ProfileViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 19.03.23.
//

import UIKit
import FirebaseAuth
import FirebaseStorage

protocol ProfileViewControllerDelegate: AnyObject {
    func signOutWasComplited()
}

class ProfileViewController: UIViewController {

    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var surnameTextField: UITextField!
    @IBOutlet var ageTextField: UITextField!
    
    weak var delegate: ProfileViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserInformation()
    }
    
    private func getUserInformation() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        APIManager.shared.getUserInformation(userId: userId) { result in
            switch result {
                case.success(let profile):
                    self.setUserInformation(profile: profile)
                case.failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    private func setUserInformation(profile: ProfileModel) {
        
        nameTextField.text = profile.name
        surnameTextField.text = profile.surname
        ageTextField.text = profile.age
    }
    
    
    
    @IBAction func signOutButton(_ sender: Any) {
        try? Auth.auth().signOut()
        delegate?.signOutWasComplited()
        /*
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
                     navigationController.popViewController
                case.failure(let error):
                    print(error.localizedDescription) // alert
            }
        }
         */
    }
    
    @IBAction func editProfileButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let editVC = storyboard.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        navigationController?.pushViewController(editVC, animated: true)
    }
    
}
