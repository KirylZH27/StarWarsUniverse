//
//  StarshipsTableViewCell.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 16.02.23.
//

import UIKit

class StarshipsTableViewCell: UITableViewCell {

  static let id = String(describing: StarshipsTableViewCell.self)
    
    @IBOutlet var pictureStarShip: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pictureStarShip.layer.cornerRadius = 12
    }

    
    
}
