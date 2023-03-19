//
//  CharactersViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 19.02.23.
//

import UIKit

class CharactersViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    
    private let emptyView: ChractersEmptyView = {
       let emptyView = ChractersEmptyView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.backgroundColor = .darkGray
        emptyView.isHidden = true
        emptyView.layer.cornerRadius = 12
        return emptyView
    }()
    
    private var characters = [CharacterModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        getCharacters()
        registerCells()
        tableView.keyboardDismissMode = .onDrag
        laoutEmptyView()
        
        self.title = "Characters"
        
        overrideUserInterfaceStyle = .dark
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)

        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .darkGray
        
        appearance.titleTextAttributes =  [NSAttributedString.Key.foregroundColor: UIColor.orange]
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
    
    private func laoutEmptyView(){
        view.addSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  16),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    //посмотреть правки if else
    private func getCharacters(by text: String = "") {
        APIManager.shared.getCharacters { result in
            switch result {
                case .success(let characters):
                    guard !text.isEmpty else {
                        self.characters = characters
                        self.tableView.reloadData()
                        self.emptyView.isHidden = true
                        return }
                    
                    let filterCharacters =  characters.filter { $0.name.lowercased().contains(text.lowercased()) }
                    self.emptyView.isHidden = !filterCharacters.isEmpty
                    self.characters = filterCharacters
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
     //   print(characters.count)
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

extension CharactersViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        getCharacters(by: searchText)
    }
}
