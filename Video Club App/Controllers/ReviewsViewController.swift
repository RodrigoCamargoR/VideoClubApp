//
//  ReviewsViewController.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 4/28/21.
//

import UIKit
import Kingfisher

class ReviewsViewController: UIViewController {
    
    @IBOutlet weak var reviewsHowMany: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var reviewsTableView: UITableView!
    
    var movie: Movie? = nil
    var movieIndex: Int = -1
    var realmDB = RealmDatabase()
    var reviews = [Review]()
    var k = K()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if movieIndex >= 0 {
            reviews = realmDB.getReviews(movieIndex)
            self.loadReviews()
        }else{
            print("No movie was passed!")
        }
        
        if NetworkMonitor.shared.isConnected {
            realmDB.addCurrentConnectionDateTime()
        }
    }
    
    func loadReviews(){
        if movie!.hasReviews(reviews.count) {
            reviewsHowMany.text = "Reviews(\(reviews.count))"
        }else{
            reviewsHowMany.text = "This movie does not have any reviews yet."
        }
        let path = k.baseImageUrl + movie!.posterImage
        let url = URL(string: path)
        let resource = ImageResource(downloadURL: url!, cacheKey: path)
        let placeholder = UIImage(named: k.dummyUser)
        self.movieImage.kf.setImage(with: resource, placeholder: placeholder, options: nil, completionHandler: nil)
        
        reviewsTableView.dataSource = self
        reviewsTableView.register(UINib(nibName: k.reviewCell, bundle: nil), forCellReuseIdentifier: k.cellIdentifier)
        
        self.reviewsTableView.reloadData()
    }

    //MARK: - Load Poster Image
    func loadMovieImage(_ path: String) {
        let url = URL(string: path)
        let resource = ImageResource(downloadURL: url!, cacheKey: path)
        let placeholder = UIImage(named: k.noPosterAvailable)
        self.movieImage.kf.setImage(with: resource, placeholder: placeholder, options: nil, completionHandler: nil)
    }
}
