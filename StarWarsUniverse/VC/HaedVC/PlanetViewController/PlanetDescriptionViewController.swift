//
//  PlanetDescriptionViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 7.03.23.
//

import UIKit
import SDWebImage

class PlanetDescriptionViewController: UIViewController {
    
    @IBOutlet var favoriteButton: UIButton!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imagePlanet: UIImageView!
    @IBOutlet var descriptionText: UITextView!
    
    var planet: PlanetModel?
    private var planetRealm: PlanetModelRealm?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = planet?.name
        descriptionText.text = planet?.description
        
        set(imageURL: URL(string: planet!.imageURLString))
        
        imagePlanet.layer.cornerRadius = 12
        
        findCurrentPlanetInRealm()
        changeButtonState()
    }
    
    func set(imageURL: URL?){
        imagePlanet.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "defaultPlanet"))
    }
    
    @IBAction func favoriteButtonWasPressed(_ sender: Any) {
        if planetRealm != nil {
            RealmManager.shared.deletePlanet(planet: planetRealm!)
            self.planetRealm = nil
        } else {
            guard let planetRealm = convertPlanetToRealm() else { return }
            RealmManager.shared.savePlanet(planet: planetRealm)
            self.planetRealm = planetRealm
        }
        changeButtonState()
    }

    private func convertPlanetToRealm() -> PlanetModelRealm? {
        guard let planet else { return nil }
        let planetRealm = PlanetModelRealm(name: planet.name, imageURLString: planet.imageURLString)
        return planetRealm
    }
    
    
    private func findCurrentPlanetInRealm(){
       var arrayPlanet = RealmManager.shared.readAllPlanets()
    
        for planet in arrayPlanet {
            if planet.name == self.planet?.name {
                self.planetRealm = planet
            }
        }
    }
    
    private func changeButtonState() {
        if planetRealm != nil {
            favoriteButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
