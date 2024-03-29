//
//  APIManager.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 6.02.23.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

class APIManager {
    
    static let shared = APIManager()
    
    private func configureFB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    func createUser(userID: String, email: String){
        let dataBase = configureFB()
        dataBase.collection("users").document(userID).setData(["email" : email])
    }
    
    func getUserInformation(userId: String,completion: @escaping (Result<ProfileModel, Error>) -> Void) {
        let dataBase = configureFB()
        dataBase.collection("users").document(userId).getDocument { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let result else { return }
                guard let data = result.data() else { return }
                guard let email = data["email"] as? String else { return }
                let name = data["name"] as? String
                let surname = data["surname"] as? String
                let age = data["age"] as? String
                let profileModel = ProfileModel(email: email, name: name, surname: surname, age: age)
                completion(.success(profileModel))
            }
        }
    }
    
    func setNewProfileInfo(userId: String, newProfile: ProfileModel, completion: @escaping (Result<Void, Error>) -> Void){
        let dataBase = configureFB()
        var data: [String: String] = ["email": newProfile.email]
        if newProfile.name != nil {
            data["name"] = newProfile.name!
        }
        if newProfile.surname != nil {
            data["surname"] = newProfile.surname!
        }
        if newProfile.age != nil {
            data["age"] = newProfile.age!
        }
        dataBase.collection("users").document(userId).setData(data) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                
                completion(.success(Void()))
                
            }
        }
    }
    
    func getFilms(completion: @escaping (Result<[FilmModel],Error>) -> Void) {
        let dataBase = configureFB()
        dataBase.collection("films").getDocuments { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let result else { return }
                var filmArray = [FilmModel]()
                
                for document in result.documents {
                    let data = document.data()
                    guard let imageURLString = data["imageURL"] as? String else {return}
                    guard let name = data["name"] as? String else { return }
                    guard let description = data["description"] as? String else { return }
                    
                    let filmModel = FilmModel(imageURLString: imageURLString, name: name, description: description)
                    filmArray.append(filmModel)
                }
                completion(.success(filmArray))
            }
        }
    }
    
    func getPlanets(completion: @escaping (Result<[PlanetModel], Error>) -> Void) {
        let dataBase = configureFB()
        dataBase.collection("planets").getDocuments { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let result else { return }
                var planetArray = [PlanetModel]()
                
                for document in result.documents {
                    let data = document.data()
                    guard let imageURLString = data["imageURL"] as? String else {return}
                    guard let name = data["name"] as? String else { return }
                    guard let description = data["description"] as? String else { return }
                    
                    let planetModel = PlanetModel(imageURLString: imageURLString, name: name, description: description)
                    planetArray.append(planetModel)
                }
                completion(.success(planetArray))
            }
        }
    }
    
    func getCharacters(completion: @escaping (Result<[CharacterModel], Error>) -> Void) {
        let dataBase = configureFB()
        dataBase.collection("characters").getDocuments { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let result else { return }
                var characterArray = [CharacterModel]()
                
                for document in result.documents {
                    let data = document.data()
                    guard let imageURLString = data["imageURL"] as? String else {return}
                    guard let name = data["name"] as? String else { return }
                    guard let description = data["description"] as? String else { return }
                    guard let type = data["type"] as? String else { return }
                    
                    let characterModel = CharacterModel(imageURLString: imageURLString, name: name, description: description, type: type)
                    characterArray.append(characterModel)
                }
                completion(.success(characterArray))
            }
        }
    }
    
    func getStarShips(completion: @escaping (Result<[StarShipModel], Error>) -> Void) {
        let dataBase = configureFB()
        dataBase.collection("starships").getDocuments { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                guard let result else { return }
                var starshipArray = [StarShipModel]()
                
                for document in result.documents {
                    let data = document.data()
                    guard let imageURLString = data["imageURL"] as? String else {return}
                    guard let name = data["name"] as? String else { return }
                    guard let description = data["description"] as? String else { return }
                    guard let firstAppearance = data["firstAppearance"] as? String else { return }
                    
                    let starshipModel = StarShipModel(imageURLString: imageURLString, name: name, description: description, firstAppearance: firstAppearance)
                    starshipArray.append(starshipModel)
                }
                completion(.success(starshipArray))
            }
        }
    }
}
