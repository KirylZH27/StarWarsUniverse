//
//  CharacterTableViewCell.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 22.02.23.
//

import UIKit
import SDWebImage

class CharacterTableViewCell: UITableViewCell {

    static let id = String(describing: CharacterTableViewCell.self)
    
    @IBOutlet var characterPicture: UIImageView!
    @IBOutlet var characterNameLabel: UILabel!
    @IBOutlet var typeCharacterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        characterPicture.layer.cornerRadius = 12
    }

    func set(imageURL: URL?, name: String, type: String){
        characterPicture.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "defaultPic"))
        characterNameLabel.text = name
        typeCharacterLabel.text = type
    }
    
    
    
}
