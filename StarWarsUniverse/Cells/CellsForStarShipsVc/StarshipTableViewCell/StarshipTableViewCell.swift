//
//  StarshipTableViewCell.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 24.02.23.
//

import UIKit
import SDWebImage

class StarshipTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageStarShip: UIImageView!
    
    static let id = String(describing: StarshipTableViewCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageStarShip.layer.cornerRadius = 12
    }
    
    func set(imageURL: URL?, name: String) {
        imageStarShip.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "defaultStarship"))
        nameLabel.text = name
    }
}
