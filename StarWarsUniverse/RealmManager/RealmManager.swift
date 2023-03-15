//
//  RealmManager.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 25.02.23.
//

import Foundation
import RealmSwift

class RealmManager {
    private let realm = try! Realm()
    
    static let shared = RealmManager()
    private init(){}
    
    func saveCharacter(character: CharacterModelRealm){
        try? realm.write({
            realm.add(character)
        })
    }
    func readAllCharacters() -> [CharacterModelRealm]{
        return Array(realm.objects(CharacterModelRealm.self))
    }
    func deleteCharacter(character: CharacterModelRealm){
        try? realm.write({
            realm.delete(character)
        })
    }
    
    
    
    func savePlanet(planet: PlanetModelRealm){
        try? realm.write({
            realm.add(planet)
        })
    }
    func readAllPlanets() -> [PlanetModelRealm]{
        return Array(realm.objects(PlanetModelRealm.self))
    }
    func deletePlanet(planet: PlanetModelRealm){
        try? realm.write({
            realm.delete(planet)
        })
    }
}
