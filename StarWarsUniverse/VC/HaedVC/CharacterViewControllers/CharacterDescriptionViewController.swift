//
//  CharacterDescriptionViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 25.02.23.
//

import UIKit
import SDWebImage

class CharacterDescriptionViewController: UIViewController {

    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    @IBOutlet var imageCharacter: UIImageView!
    
    var character: CharacterModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCharacter.layer.cornerRadius = 12
        nameLabel.text = character?.name
        typeLabel.text = character?.type
        descriptionLabel.text = character?.description
        
        set(imageURL: URL(string:character!.imageURLString))
    }
    func set(imageURL: URL?){
        imageCharacter.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "defaultPic"))
    }
}
