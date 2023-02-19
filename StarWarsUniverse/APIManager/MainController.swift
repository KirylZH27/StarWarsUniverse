//
//  MainController.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 7.02.23.
//

import UIKit

class MainController: UIViewController {

    @IBOutlet var pictureHeroe: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func action1(_ sender: Any) {
        APIManager.shared.getPost(collection: "heroes", docName: "LukeSkywalker", completion: { doc in
            guard doc != nil else { return }
            self.nameLabel.text = doc?.field1
            self.descriptionLabel.text = doc?.field2
        })
        APIManager.shared.getimage(picName: "Люк Скайуокер1", completion: { pic in
            self.pictureHeroe.image = pic
        })
    }
    
    
    @IBAction func action2(_ sender: Any) {
        APIManager.shared.getPost(collection: "heroes", docName: "HanSolo", completion: { doc in
            guard doc != nil else { return }
            self.nameLabel.text = doc?.field1
            self.descriptionLabel.text = doc?.field2
        })
        APIManager.shared.getimage(picName: "Хан Соло", completion: { pic in
            self.pictureHeroe.image = pic
        })
    }
    
    
    @IBAction func action3(_ sender: Any) {
        APIManager.shared.getPost(collection: "heroes", docName: "DarthVader", completion: { doc in
            guard doc != nil else { return }
            self.nameLabel.text = doc?.field1
            self.descriptionLabel.text = doc?.field2
        })
        APIManager.shared.getimage(picName: "Дарт Вейдер", completion: { pic in
            self.pictureHeroe.image = pic
        })
    }
    
}
