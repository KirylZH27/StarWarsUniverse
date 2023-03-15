//
//  MainNavigationViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 12.03.23.
//

import UIKit
import FirebaseAuth

class MainNavigationViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAuthorization()
    }
    
    private func checkAuthorization() {
        if Auth.auth().currentUser != nil {
            presentTabBarViewController()
        } else {
            presentAuthorizationViewController()
        }
    }
    
    private func presentTabBarViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        addFullScreen(childViewController: viewController)
    }
    
    private func presentAuthorizationViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AuthorizationViewController") as! AuthorizationViewController
        let navigationViewController = UINavigationController(rootViewController: viewController)
        addFullScreen(childViewController: navigationViewController)
    }
    
}


