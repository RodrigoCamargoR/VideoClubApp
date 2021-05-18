//
//  MovieViewController.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 4/24/21.
//

import UIKit
import RealmSwift
import Kingfisher

class MovieViewController: UIViewController {

    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var peopleWatching: UILabel!
    @IBOutlet weak var genres: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var starsRate: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var gradientImage: UIImageView!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentStackView: UIStackView!
    @IBOutlet weak var mainContentView: UIView!
    
    var movie: Movie? = nil
    var movieIndex: Int = 0
    let k = K()
    let movieViewModel = MovieModel()
    let realmDB = RealmDatabase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if movie != nil {
            movieTitle.text = movie!.title
            peopleWatching.text = "\(Int(movie!.popularity)) people watching"
            rate.text = String(movie!.rate)
            gradientImage.image = UIImage(named: "Gradient")
            movieDescription.text = movie!.overview
            loadPosterImage(movie!.posterImage)
            loadHeaderImage(movie!.secondImg)
            changeStarsImage(movie!.rate)
            loadGenres(movie!.genres)
        }
    }
    
    @IBAction func reviewsTapped(_ sender: UIButton) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ReviewsViewController") as?  ReviewsViewController{
            vc.movie = movie
            vc.movieIndex = movieIndex
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    //MARK: - Pull genres and write them in the page
    func loadGenres(_ genres: List<Int>) {
        self.genres.text = ""
        let realmDb = RealmDatabase()
        for (index, g) in genres.enumerated(){
            let genre = realmDb.getGenre(g)
            if index == genres.count - 1{
                self.genres.text! += "\(genre.name)"
            }
            else{
                self.genres.text! += "\(genre.name), "
            }
        }
    }
    
    //MARK: - Change stars image
    func changeStarsImage(_ i: Double) {
        let starsAmount = movieViewModel.getStarsAmount(movie!.rate)
        switch starsAmount {
        case 5:
            starsRate.image = UIImage(named: "5stars")
        case 4:
            starsRate.image = UIImage(named: "4stars")
        case 3:
            starsRate.image = UIImage(named: "3stars")
        case 2:
            starsRate.image = UIImage(named: "2stars")
        case 1:
            starsRate.image = UIImage(named: "1star")
        default:
            starsRate.image = UIImage(named: "0stars")
        }
    }
    
    //MARK: - Load Poster Image
    func loadPosterImage(_ path: String) {
        let posterImageURL = k.baseImageUrl + path
        let url = URL(string: posterImageURL)
        let resource = ImageResource(downloadURL: url!, cacheKey: posterImageURL)
        self.posterImage.kf.setImage(with: resource, placeholder: nil, options: nil, completionHandler: nil)
        self.posterImage.layer.cornerRadius = 10
        
    }
    
    //MARK: - Load Header Image
    func loadHeaderImage(_ path: String) {
        let headerImageURL = k.baseImageUrl + path
        let url = URL(string: headerImageURL)
        let resource = ImageResource(downloadURL: url!, cacheKey: headerImageURL)
        headerImage.kf.setImage(with: resource, placeholder: nil, options: nil, completionHandler: nil)
        headerImage.contentMode = .top
        headerImage.clipsToBounds = true
        headerImage.image = headerImage.image!.resizeTopAlignedToFill(newWidth: headerImage.frame.width)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            if self.scrollView.frame.width > 1000 {
                applyLandscapeStylesiPad()
            }else{
                applyLandscapeStylesiPhone()
            }
            self.headerImage.contentMode = .scaleAspectFill
            self.headerImage.clipsToBounds = true
        } else {
            self.headerImage.contentMode = .top
            applyPortraitStyles()
        }
    }
    
    func applyLandscapeStylesiPad(){
        movieTitle.font = movieTitle.font.withSize(40)
        peopleWatching.font = peopleWatching.font.withSize(30)
        rate.font = rate.font.withSize(40)
        movieDescription.font = movieDescription.font.withSize(30)
        genres.font = genres.font.withSize(25)
    }
    func applyLandscapeStylesiPhone() {
        movieTitle.font = movieTitle.font.withSize(30)
        peopleWatching.font = peopleWatching.font.withSize(20)
        rate.font = rate.font.withSize(30)
        movieDescription.font = movieDescription.font.withSize(20)
        genres.font = genres.font.withSize(17)
    }
    
    func applyPortraitStyles(){
        movieTitle.font = movieTitle.font.withSize(25)
        peopleWatching.font = peopleWatching.font.withSize(17)
        rate.font = rate.font.withSize(25)
        movieDescription.font = movieDescription.font.withSize(20)
        genres.font = genres.font.withSize(14)
    }
    
    class CollectionViewController: UIViewController {
        @IBOutlet weak var collectionView: UICollectionView!
    }
    
}
