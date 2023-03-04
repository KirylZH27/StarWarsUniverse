//
//  CharacterModelRealm.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 25.02.23.
//

import Foundation
import RealmSwift

class CharacterModelRealm: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var imageURLString: String = ""
    
    convenience init(name: String, type: String, imageURLString: String) {
        self.init()
        self.name = name
        self.type = type
        self.imageURLString = imageURLString
    }
}

