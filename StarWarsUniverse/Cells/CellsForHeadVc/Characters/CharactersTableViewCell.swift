//
//  CharactersTableViewCell.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 16.02.23.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {

    static let id = String(describing: CharactersTableViewCell.self)

    @IBOutlet var pictureCharacters: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pictureCharacters.layer.cornerRadius = 12
    }
}
