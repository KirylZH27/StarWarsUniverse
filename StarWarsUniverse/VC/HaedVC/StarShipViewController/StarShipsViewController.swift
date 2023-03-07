//
//  StarShipsViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 19.02.23.
//

import UIKit

class StarShipsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
        
        self.title = "Starships"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func registerCells() {
        let nib = UINib(nibName: StarshipTableViewCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: StarshipTableViewCell.id)
    }
    

}

extension StarShipsViewController: UITableViewDelegate {
    
}

extension StarShipsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StarshipTableViewCell.id, for: indexPath)
        guard let characterCell = cell as? StarshipTableViewCell else
        { return cell }
        return characterCell
    }
    
    
}
