//
//  FavoriteTableViewCell.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 4.03.23.
//

import UIKit
import SDWebImage

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var imageElement: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageElement.layer.cornerRadius = 12
    }
    
    func set(name: String, imageURL: URL?){
        self.nameLabel.text = name
        self.imageElement.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "defaultPic"))
    }

   
}
