//
//  StarShipsViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 19.02.23.
//

import UIKit

class StarShipsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var starships = [StarShipModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getStarShips()
        registerCells()
        
        
        self.title = "Starships"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .darkGray
        navigationController?.navigationBar.tintColor = .systemRed
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        
        let apperanceTabBar = UITabBarAppearance()
        apperanceTabBar.backgroundColor = .darkGray
        tabBarController?.tabBar.tintColor = .systemRed
        tabBarController?.tabBar.standardAppearance = apperanceTabBar
        tabBarController?.tabBar.scrollEdgeAppearance = apperanceTabBar
    }

    private func getStarShips() {
        APIManager.shared.getStarShips { result in
            switch result {
                case .success(let success):
                    self.starships = success
                    self.tableView.reloadData()
                case .failure(let failure):
                    print(failure)
            }
        }
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
        return starships.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StarshipTableViewCell.id, for: indexPath)
        guard let starshipCell = cell as? StarshipTableViewCell else
        { return cell }
        let imageURL = URL(string: starships[indexPath.row].imageURLString)
        let name = String(starships[indexPath.row].name)
        starshipCell.set(imageURL: imageURL, name: name)
        return starshipCell
    }
    
    
}
