//
//  FilmDescriptionViewController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 4.03.23.
//

import UIKit
import SDWebImage

class FilmDescriptionViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var imageFilm: UIImageView!
    @IBOutlet var descriptiontext: UITextView!
    
    var film: FilmModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = film?.name
        descriptiontext.text = film?.description
        
        set(imageURL: URL(string: film!.imageURLString))
        
    }
    func set(imageURL: URL?){
        imageFilm.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "starship2"))
    }
}
