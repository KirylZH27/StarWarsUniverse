//
//  FilmsTableViewCell.swift
//  StarWarsUniverse
//
//  Created by Кирилл Жогальский on 16.02.23.
//

import UIKit
protocol FilmsTableViewCellDelegate: AnyObject {
    func didSelectFilm(film: FilmModel)
}
class FilmsTableViewCell: UITableViewCell {

    static let id = String(describing: FilmsTableViewCell.self)
    weak var delegate: FilmsTableViewCellDelegate?
    
    private var films = [FilmModel]()

    
    @IBOutlet var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        registerCell()
    }
    
    func set(films: [FilmModel]) {
        self.films = films
        collectionView.reloadData()
    }
    
 private func registerCell() {
        let nib = UINib(nibName: FilmCollectionViewCell.id, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: FilmCollectionViewCell.id)
    }
}

extension FilmsTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let film = films[indexPath.row]
     /*   
      */
        delegate?.didSelectFilm(film: film)
    }
    
    
}

extension FilmsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilmCollectionViewCell.id, for: indexPath)
            guard let filmsCell = cell as? FilmCollectionViewCell else
                { return cell }
        let imageURL = URL(string: films[indexPath.row].imageURLString)
        
        filmsCell.set(imageURL: imageURL)
        return filmsCell
    }
    
    
}

extension FilmsTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 300, height: 180)

    }
}
