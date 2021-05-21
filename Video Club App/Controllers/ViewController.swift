//
//  ViewController.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 4/21/21.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    @IBOutlet weak var movieListTable: UITableView!
    @IBOutlet weak var moviesTitle: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = MovieModel()
    var genreModel = GenreModel()
    var reviewModel = ReviewModel()
    let k = Constants()
    let realmDB = RealmDatabase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register de Collection View Cell inside of the Collection View
        collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: k.cvcIndentifier)
        
        if NetworkMonitor.shared.isConnected {
            // Online mode
            realmDB.deleteAllData()
            loadMovies()
            genreModel.fetchGenres()
        }else{
            // Offline mode
            let today = Date()
            let date = realmDB.getLastConnecionDate()
            if today.timeIntervalSince(date) > (k.connectionHours * 3600) {
                realmDB.deleteAllData()
                loadConnectToInternetAlert()
            }else{
                loadRealmMovies()
            }
        }
        
        // Set the Collection View Flow Layout to apply the structure
        let layout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = layout
    }

    func loadConnectToInternetAlert(){
        let alert = UIAlertController(title: k.alertTitle, message: k.alertBody, preferredStyle: .alert)
        
        present(alert, animated: true)
    }
    
    // Loads the movies into the App calling the API
    func loadMovies()  {
        viewModel.fetchMovies { [weak self] in
            self?.collectionView.dataSource = self
            self?.collectionView.reloadData()
        }
    }
    
    // Loads the movies into the App directly from Realm
    func loadRealmMovies(){
        viewModel.loadMoviesFromRealm()
    }
    
}

