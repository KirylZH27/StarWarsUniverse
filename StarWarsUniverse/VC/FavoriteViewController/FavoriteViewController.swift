//
//  FavoriteViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 4.03.23.
//

import UIKit

class FavoriteViewController: UIViewController {

    enum SegmentType {
        case characters
        case films
        case starships
    }
    
    private var currentSegment: SegmentType = .characters
    
    @IBOutlet var segmentController: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    private let emptyView: FavouriteEmptyView = {
       let emptyView = FavouriteEmptyView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.backgroundColor = .systemRed
        emptyView.isHidden = true
        emptyView.layer.cornerRadius = 12
        return emptyView
    }()
    
    
    private var charactersArray: [CharacterModelRealm] = []
    private var filmsArray = [String]()
    private var starshipsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        laoutEmptyView()
        tableView.dataSource = self
        registerCells()
        
        overrideUserInterfaceStyle = .dark
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCharacters()
        
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .darkGray
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let apperanceTabBar = UITabBarAppearance()
        apperanceTabBar.backgroundColor = .darkGray
        tabBarController?.tabBar.tintColor = .systemRed
        tabBarController?.tabBar.standardAppearance = apperanceTabBar
        tabBarController?.tabBar.scrollEdgeAppearance = apperanceTabBar
    }
    
    
    @IBAction func segmentControllerWasPressed(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0: currentSegment = .characters
            case 1: currentSegment = .films
            case 2: currentSegment = .starships
            default: break
        }
        tableView.reloadData()
        checkEmpty()
    }
    
    private func getCharacters() {
        charactersArray = RealmManager.shared.readAllCharacters()
        tableView.reloadData()
        checkEmpty()
    }
    
    private func laoutEmptyView(){
        view.addSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  16),
            emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func checkEmpty() {
        switch currentSegment {
            case .characters:
                emptyView.isHidden = !charactersArray.isEmpty
            case .films:
                emptyView.isHidden = !filmsArray.isEmpty
            case .starships:
                emptyView.isHidden = !starshipsArray.isEmpty
        }
    }
    
    private func registerCells() {
        let nib = UINib(nibName: String(describing: FavoriteTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: FavoriteTableViewCell.self))
    }
    

    
}


extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch currentSegment {
            case .characters:
                return charactersArray.count
            case .films:
                return filmsArray.count
            case .starships:
                return starshipsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavoriteTableViewCell.self), for: indexPath)
        guard let favoriteCell = cell as? FavoriteTableViewCell else
        { return cell }
        
        switch currentSegment {
            case .characters:
                let imageURL = URL(string: charactersArray[indexPath.row].imageURLString)
                favoriteCell.set(name: charactersArray[indexPath.row].name, imageURL: imageURL)
            case .films:
                let imageURL = URL(string: charactersArray[indexPath.row].imageURLString)
                favoriteCell.set(name: filmsArray[indexPath.row], imageURL: imageURL )
            case .starships:
                let imageURL = URL(string: charactersArray[indexPath.row].imageURLString)
                favoriteCell.set(name: starshipsArray[indexPath.row], imageURL: imageURL)
        }
        
        return favoriteCell
    }
}

