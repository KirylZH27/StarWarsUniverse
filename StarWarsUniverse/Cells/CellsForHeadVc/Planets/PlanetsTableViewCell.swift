//
//  PlanetsTableViewCell.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 20.02.23.
//

import UIKit

class PlanetsTableViewCell: UITableViewCell {

    static let id = String(describing: PlanetsTableViewCell.self)
    
    private var planets = [PlanetModel]()
    
    @IBOutlet var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        registerCell()
    }
    
    func set(planets: [PlanetModel]){
        self.planets = planets
        collectionView.reloadData()
    }

    private func registerCell() {
           let nib = UINib(nibName: PlanetCollectionViewCell.id, bundle: nil)
           collectionView.register(nib, forCellWithReuseIdentifier: PlanetCollectionViewCell.id)
    }
}

extension PlanetsTableViewCell: UICollectionViewDelegate {
    
}

extension PlanetsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return planets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlanetCollectionViewCell.id, for: indexPath)
        guard let planetsCell = cell as? PlanetCollectionViewCell else
            { return cell }
        let imageURL = URL(string: planets[indexPath.row].imageURLString)
        planetsCell.set(imageURL: imageURL)
        
        return planetsCell
    }
    
    
}
extension PlanetsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 180, height: 180)
    }
}
