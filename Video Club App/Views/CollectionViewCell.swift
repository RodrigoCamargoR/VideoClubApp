//
//  CollectionViewCell.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 4/22/21.
//

import UIKit
import Kingfisher

protocol CollectionViewCellDelegate: class {
    // Declare a delegate function holding a reference to `UICollectionViewCell` instance
    func collectionViewCell(_ cell: UICollectionViewCell, buttonTapped: UIButton)
}

class CollectionViewCell: UICollectionViewCell {
    
//    @IBOutlet weak var moviePoster: UIButton!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
    @IBOutlet weak var movieRatings: UILabel!
    @IBOutlet weak var movieID: UIButton!
    
    weak var delegate: CollectionViewCellDelegate?
    let k = K()
    
    func setCellWithValuesOf(_ movie: Movie) {
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, poster: movie.posterImage, id: String(movie.id), headerImg: movie.secondImg)
    }
    
//MARK: - Update the UI of the cell
    func updateUI (title: String?, releaseDate: String?, rating: Double?, poster: String?, id: String?, headerImg: String){
        self.movieTitle.text = title ?? ""
        self.movieYear.text = convertDateToYear(releaseDate)
        guard let rate = rating  else { return }
        self.movieRatings.text = String(rate)
        
        guard let posterString = poster else { return }
        let posterUrlString = k.baseImageUrl + posterString
        let headerUrlString = k.baseImageUrl + headerImg
        
        
        if URL(string: posterUrlString) != nil {
            let url = URL(string: posterUrlString)
            let resource = ImageResource(downloadURL: url!, cacheKey: posterUrlString)
            self.moviePoster.kf.setImage(with: resource, placeholder: nil, options: nil, completionHandler: nil)
        } else {
            self.moviePoster.image = UIImage(named: self.k.noPosterAvailable)
        }
        
        // Save header Image to Cache
        if URL(string: headerUrlString) != nil {
            let url = URL(string: headerUrlString)
            let resource = ImageResource(downloadURL: url!, cacheKey: headerUrlString)
            KingfisherManager.shared.retrieveImage(with: resource) { (result) in
                switch result {
                case .failure(let err):
                    print(err.localizedDescription)
                case .success(_):
                    return
                }
            }
        }

            
    }
    
//MARK: - Format date
    func convertDateToYear(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate){
                dateFormatter.dateFormat = "yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
    
    
    static func nib() -> UINib{
        return UINib(nibName: "CollectionViewCell", bundle: nil)
    }
}
