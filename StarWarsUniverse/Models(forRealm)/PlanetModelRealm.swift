//
//  PlanetModelRealm.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 10.03.23.
//

import Foundation
import RealmSwift

class PlanetModelRealm: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var imageURLString: String = ""
    
    convenience init(name: String, imageURLString: String) {
        self.init()
        self.name = name
        self.imageURLString = imageURLString
    }
}
