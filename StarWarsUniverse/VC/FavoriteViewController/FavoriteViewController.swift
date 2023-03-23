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
        case planets
        case starships
    }
    
    private var currentSegment: SegmentType = .characters
    
    @IBOutlet var segmentController: UISegmentedControl!
    @IBOutlet var tableView: UITableView!
    
    private let emptyView: FavouriteEmptyView = {
       let emptyView = FavouriteEmptyView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyView.backgroundColor = .darkGray
        emptyView.isHidden = true
        emptyView.layer.cornerRadius = 12
        return emptyView
    }()
    
    private var charactersArray: [CharacterModelRealm] = []
    private var planetsArray: [PlanetModelRealm] = []
    private var starshipsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        laoutEmptyView()
        tableView.dataSource = self
        tableView.delegate = self
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCharacters()
        getPlanets()
        parametersForViewWillAppear()
    }
    
    private func parametersForViewWillAppear (){
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
            case 1: currentSegment = .planets
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
    
    private func getPlanets() {
        planetsArray = RealmManager.shared.readAllPlanets()
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
            case .planets:
                emptyView.isHidden = !planetsArray.isEmpty
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
            case .planets:
                return planetsArray.count
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
            case .planets:
                let imageURL = URL(string: planetsArray[indexPath.row].imageURLString)
                favoriteCell.set(name: planetsArray[indexPath.row].name, imageURL: imageURL )
            case .starships:
                let imageURL = URL(string: charactersArray[indexPath.row].imageURLString)
                favoriteCell.set(name: starshipsArray[indexPath.row], imageURL: imageURL)
        }
        return favoriteCell
    }
    
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch currentSegment {
                    
                case .characters:
                    RealmManager.shared.deleteCharacter(character: charactersArray[indexPath.row])
                    charactersArray.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    tableView.reloadData()
                    checkEmpty()
                case .planets:
                    RealmManager.shared.deletePlanet(planet: planetsArray[indexPath.row])
                    planetsArray.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    tableView.reloadData()
                    checkEmpty()
                case .starships:
                    print("")
            }
        }
    }
}

