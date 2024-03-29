//
//  HeadViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 16.02.23.
//

import UIKit

class HeadViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
   var elemets: [enumHead] = enumHead.allCases
   private var films = [FilmModel]()
   private var planets = [PlanetModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getFilms()
        getPlanets()
        registerCells()
   //     saveInRealm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func getFilms() {
        APIManager.shared.getFilms { result in
            switch result {
                case .success(let films):
                    self.films = films
                    self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
    private func getPlanets() {
        APIManager.shared.getPlanets { result in
            switch result {
                case .success(let planets):
                    self.planets = planets
                    self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
    
   private func registerCells() {
        let nib = UINib(nibName: CharactersTableViewCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CharactersTableViewCell.id)
        let nib2 = UINib(nibName: FilmsTableViewCell.id, bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: FilmsTableViewCell.id)
        let nib3 = UINib(nibName: StarshipsTableViewCell.id, bundle: nil)
        tableView.register(nib3, forCellReuseIdentifier: StarshipsTableViewCell.id)
       let nib4 = UINib(nibName: PlanetsTableViewCell.id, bundle: nil)
       tableView.register(nib4, forCellReuseIdentifier: PlanetsTableViewCell.id)
    }
    
  /*  func saveInRealm(){
     //   RealmManager.shared.saveCharacter(character: CharacterModelRealm(name: "TestName", type: "TestType", imageURLString: "TestURl"))
     //   RealmManager.shared.saveCharacter(character: CharacterModelRealm(name: "TestName2", type: "TestType2", imageURLString: "TestURl2"))
        let array = RealmManager.shared.readAllCharacters()
        array.forEach { RealmManager.shared.deleteCharacter(character: $0)
        }
    //    RealmManager.shared.deleteCharacter(character: array[0])
    }
   */
}

extension HeadViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
            case 0:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let charactersVC = storyboard.instantiateViewController(withIdentifier: "CharactersViewController") as! CharactersViewController
                navigationController?.pushViewController(charactersVC, animated: true)
            case 2:
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let starshipsVC = storyboard.instantiateViewController(withIdentifier: "StarShipsViewController") as! StarShipsViewController
                navigationController?.pushViewController(starshipsVC, animated: true)
            default:
                break
        }
    }
}

extension HeadViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        elemets.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = HeadTableViewHeaderView()
        switch section {
            case 0:
                view.setTitle(text: "Characters")
                return view
            case 1:
                view.setTitle(text: "Films")
                return view
            case 2:
                view.setTitle(text: "Starships")
                return view
            case 3:
                view.setTitle(text: "Planets")
                return view
            default:
                return nil
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.id, for: indexPath)
                guard let charactersCell = cell as? CharactersTableViewCell else
                { return cell }
                return charactersCell
                
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: FilmsTableViewCell.id, for: indexPath)
                guard let filmsCell = cell as? FilmsTableViewCell else
                { return cell }
                filmsCell.set(films: films)
                filmsCell.delegate = self
                return filmsCell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: StarshipsTableViewCell.id, for: indexPath)
                guard let starshipsCell = cell as? StarshipsTableViewCell else
                { return cell }
                return starshipsCell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: PlanetsTableViewCell.id, for: indexPath)
                guard let planetsCell = cell as? PlanetsTableViewCell else
                { return cell }
                planetsCell.set(planets: planets)
                planetsCell.delegate = self
                return planetsCell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.id, for: indexPath)
                guard let charactersCell = cell as? CharactersTableViewCell else
                { return cell }
                return charactersCell
        }
        
    //    let typeCell = elemets[indexPath.row]
        /*
         switch typeCell {
         case .characters:
         let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.id, for: indexPath)
         guard let charactersCell = cell as? CharactersTableViewCell else
         { return cell }
         return charactersCell
         
         case .films:
         let cell = tableView.dequeueReusableCell(withIdentifier: FilmsTableViewCell.id, for: indexPath)
         guard let filmsCell = cell as? FilmsTableViewCell else
         { return cell }
         return filmsCell
         
         case .starships:
         let cell = tableView.dequeueReusableCell(withIdentifier: StarshipsTableViewCell.id, for: indexPath)
         guard let starshipsCell = cell as? StarshipsTableViewCell else
         { return cell }
         return starshipsCell
         default:
         break
         }
         }
         */
    }
}

extension HeadViewController: FilmsTableViewCellDelegate {
    func didSelectFilm(film: FilmModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let filmsVC = storyboard.instantiateViewController(withIdentifier: "FilmDescriptionViewController") as! FilmDescriptionViewController
           filmsVC.film = film
           present(filmsVC, animated: true)
    }
}

extension HeadViewController: PlanetsTableViewCellDelegate {
    func didSelectPlanet(planet: PlanetModel) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let planetVC = storyboard.instantiateViewController(withIdentifier: "PlanetDescriptionViewController") as! PlanetDescriptionViewController
        planetVC.planet = planet
        present(planetVC, animated: true)
    }
}
