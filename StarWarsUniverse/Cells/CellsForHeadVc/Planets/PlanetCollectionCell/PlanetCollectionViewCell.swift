//
//  PlanetCollectionViewCell.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 20.02.23.
//

import UIKit
import SDWebImage

class PlanetCollectionViewCell: UICollectionViewCell {

    static let id = String(describing: PlanetCollectionViewCell.self)
    
    @IBOutlet var viewForPicture: UIView!
    @IBOutlet var picturePlanet: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewForPicture.layer.cornerRadius = 12
        picturePlanet.layer.cornerRadius = 12
    }

    func set(imageURL: URL?){
        picturePlanet.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "defaultPlanet"))
    }
}
