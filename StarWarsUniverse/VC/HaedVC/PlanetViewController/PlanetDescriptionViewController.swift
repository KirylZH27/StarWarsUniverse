//
//  PlanetDescriptionViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 7.03.23.
//

import UIKit
import SDWebImage

class PlanetDescriptionViewController: UIViewController {

    var planet: PlanetModel?
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var imagePlanet: UIImageView!
    @IBOutlet var descriptionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = planet?.name
        descriptionText.text = planet?.description
        
        set(imageURL: URL(string: planet!.imageURLString))
        
        imagePlanet.layer.cornerRadius = 12
    }
    
    func set(imageURL: URL?){
        imagePlanet.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "defaultPlanet"))
    }


}
