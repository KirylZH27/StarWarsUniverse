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
    
    func getPost(collection: String, docName: String, completion: @escaping (Document?) -> Void) {
        let db = configureFB()
        db.collection(collection).document(docName).getDocument(completion: { (document, error) in
            guard error == nil else { completion(nil); return }
            let doc = Document(field1: document?.get("field1") as! String, field2: document?.get("field2") as! String)
            completion(doc)
        })
    }
    func getimage(picName: String, completion: @escaping (UIImage) -> Void) {
        
        let storage = Storage.storage()
        let reference = storage.reference()
        let pathRef = reference.child("pictures")
        
        var image: UIImage = UIImage(named: "defaultPic")!
        let fileRef = pathRef.child(picName + ".jpeg")
        fileRef.getData(maxSize: 1024*1024, completion: { data, error in
            guard error == nil else { completion(image); return }
            image = UIImage( data: data!)!
            completion(image)
        })
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
}
