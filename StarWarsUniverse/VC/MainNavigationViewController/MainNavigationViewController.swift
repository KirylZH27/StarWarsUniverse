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
        let tabBarViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! TabBarController
        let profileNavController = tabBarViewController.viewControllers?.last as? UINavigationController
        let profileViewController = profileNavController?.viewControllers.first as? ProfileViewController
        profileViewController?.delegate = self
    
        addFullScreen(childViewController: tabBarViewController)
        
    }
    
    private func presentAuthorizationViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AuthorizationViewController") as! AuthorizationViewController
        let navigationViewController = UINavigationController(rootViewController: viewController)
        viewController.delegate = self
        addFullScreen(childViewController: navigationViewController)
    }
    
    private func hideAuthorizationViewController() {
        guard let childVC = children.first else { return }
        remove(childViewController: childVC)
    }
    
    private func hideTabBarViewController(){
        guard let childVC = children.first else { return }
        remove(childViewController: childVC)
        
    }
}

extension MainNavigationViewController: AuthorizationViewControllerDelegate {
    func authWasComplited() {
        hideAuthorizationViewController()
        presentTabBarViewController()
    }
    
}

extension MainNavigationViewController: ProfileViewControllerDelegate {
    func signOutWasComplited() {
        hideTabBarViewController()
        presentAuthorizationViewController()
    }
}

