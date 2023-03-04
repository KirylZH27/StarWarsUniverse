//
//  CharactersViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 19.02.23.
//

import UIKit

class CharactersViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var characters = [CharacterModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()

        getCharacters()
        
        self.title = "Characters"
        overrideUserInterfaceStyle = .dark
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
 //       navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance()
                appearance.backgroundColor = .darkGray
                
        
                navigationController?.navigationBar.tintColor = .white
                navigationController?.navigationBar.standardAppearance = appearance
                navigationController?.navigationBar.compactAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let apperanceTabBar = UITabBarAppearance()
        apperanceTabBar.backgroundColor = .darkGray
        tabBarController?.tabBar.tintColor = .white
        tabBarController?.tabBar.standardAppearance = apperanceTabBar
        tabBarController?.tabBar.scrollEdgeAppearance = apperanceTabBar
    }
    
    private func getCharacters() {
        APIManager.shared.getCharacters { result in
            switch result {
                case .success(let success):
                    self.characters = success
                    self.tableView.reloadData()
                case .failure(let failure):
                    print(failure)
            }
        }
    }
    
    
    
    private func registerCells() {
        let nib = UINib(nibName: CharacterTableViewCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CharacterTableViewCell.id)
    }
    
    

}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let charactersVC = storyboard.instantiateViewController(withIdentifier: "CharacterDescriptionViewController") as! CharacterDescriptionViewController
        charactersVC.character = character
        present(charactersVC, animated: true)
    }
}
extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(characters.count)
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.id, for: indexPath)
        guard let characterCell = cell as? CharacterTableViewCell else
        { return cell }
        
        let imageURL = URL(string: characters[indexPath.row].imageURLString)
        
        let name = String (characters[indexPath.row].name)
        let type = String (characters[indexPath.row].type)
        characterCell.set(imageURL: imageURL, name: name, type: type)
        
        return characterCell
    }
    
    
}
