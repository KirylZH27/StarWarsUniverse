//
//  FilmCollectionViewCell.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 16.02.23.
//

import UIKit
import SDWebImage

class FilmCollectionViewCell: UICollectionViewCell {

    static let id = String(describing: FilmCollectionViewCell.self)
    
    
    @IBOutlet var viewForPicture: UIView!
    @IBOutlet var pictureFilm: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewForPicture.layer.cornerRadius = 12
        pictureFilm.layer.cornerRadius = 12
    }
    
    func set(imageURL: URL?){
        pictureFilm.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "defaultPic"))
    }

    
}
