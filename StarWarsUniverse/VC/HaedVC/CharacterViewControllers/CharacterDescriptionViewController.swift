//
//  CharacterDescriptionViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 25.02.23.
//

import UIKit
import SDWebImage

class CharacterDescriptionViewController: UIViewController {
    
    @IBOutlet var favoriteButton: UIButton!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var imageCharacter: UIImageView!
    
    var character: CharacterModel?
    private var characterRealm: CharacterModelRealm?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCharacter.layer.cornerRadius = 12
        nameLabel.text = character?.name
        typeLabel.text = character?.type
        descriptionLabel.text = character?.description
        
        set(imageURL: URL(string:character!.imageURLString))
        
        findCurrentCharacterInRealm()
        changeButtonState()
    }
    
    
    @IBAction func favoriteButtonWasPressed(_ sender: Any) {
        if characterRealm != nil {
            RealmManager.shared.deleteCharacter(character: characterRealm!)
            self.characterRealm = nil
        } else {
            guard let characterRealm = convertCharacterToRealm() else { return }
            RealmManager.shared.saveCharacter(character: characterRealm)
            self.characterRealm = characterRealm
        }
        changeButtonState()
    }
    
    private func convertCharacterToRealm() -> CharacterModelRealm? {
        guard let character else { return nil }
        let characterRealm = CharacterModelRealm(name: character.name, type: character.type, imageURLString: character.imageURLString)
        return characterRealm
    }
    
    
   private func set(imageURL: URL?){
        imageCharacter.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "defaultPic"))
    }
    
    private func findCurrentCharacterInRealm(){
       var arrayCharacter = RealmManager.shared.readAllCharacters()
    
        for character in arrayCharacter {
            if character.name == self.character?.name {
                self.characterRealm = character
            }
        }
    }
    
    private func changeButtonState() {
        if characterRealm != nil {
            favoriteButton.setBackgroundImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
