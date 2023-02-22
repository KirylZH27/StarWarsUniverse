//
//  StarShipsViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 19.02.23.
//

import UIKit

class StarShipsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    

}
