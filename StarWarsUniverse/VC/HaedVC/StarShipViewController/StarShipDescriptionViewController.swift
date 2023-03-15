//
//  StarShipDescriptionViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 10.03.23.
//

import UIKit
import SDWebImage

class StarShipDescriptionViewController: UIViewController {

    @IBOutlet var imageStarShip: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionText: UITextView!
    @IBOutlet var firstAppearanceLabel: UILabel!
    
    var starship: StarShipModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = starship?.name
        descriptionText.text = starship?.description
        firstAppearanceLabel.text = starship?.firstAppearance
        
        set(imageURL: URL(string: starship!.imageURLString))
    }
    
    private func set(imageURL: URL?){
        imageStarShip.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "defaultStarship"))
    }
}
