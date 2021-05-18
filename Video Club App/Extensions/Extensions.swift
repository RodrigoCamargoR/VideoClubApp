//
//  Extensions.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 4/22/21.
//

import UIKit
import Kingfisher

//MARK: - UICollectionViewDataSource

extension ViewController : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRows(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Create cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: k.cvcIndentifier, for: indexPath) as! CollectionViewCell
        
        // Add movie to cell
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        
        // Apply some styling to the cells
        cell.moviePoster.clipsToBounds = true
        cell.moviePoster.contentMode = .scaleAspectFill
        cell.layer.cornerRadius = 10
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension ViewController : UICollectionViewDelegate{
    // Returns the index movie that was selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        let realmDb = RealmDatabase()
        let selectedMovie = realmDb.getMovie(index)
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieViewController") as?  MovieViewController{
            vc.movie = selectedMovie
            vc.movieIndex = index
            self.navigationController?.pushViewController(vc, animated: true)
            if NetworkMonitor.shared.isConnected{
                self.reviewModel.fetchReviews(String(selectedMovie.id), String(index))
            }
        }
    }
}


//MARK: - UICollectionViewDelegateFlowLayout

extension ViewController : UICollectionViewDelegateFlowLayout {
    
    // Set Cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // Get width of the screen
        let bounds = collectionView.bounds
        
        // Show 2 movies per row
        var cellSize = bounds.width/2
      
        // Check if the screen is wider than 500 points
        // If so, show 3 movies per row
        if bounds.width > 500 {
            cellSize = bounds.width/3
        }
        let height: CGFloat = bounds.height/2.5
        
        return CGSize(width: cellSize - 7, height: height)
    }
    
    // Separation between the Cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

//MARK: - ReviewsViewController
extension ReviewsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: k.cellIdentifier, for: indexPath) as! ReviewCell
        let i = indexPath.row
        cell.authorLabel.text = reviews[i].authorUser
        cell.reviewLabel.text = reviews[i].content
        
        if reviews[i].authorAvatar == "Na"{
            cell.userImage.image = UIImage(named: k.dummyUser)
        }else{
            let userImageURL = k.userImageBase + reviews[i].authorAvatar
            let url = URL(string: userImageURL)
            let resource = ImageResource(downloadURL: url!, cacheKey: userImageURL)
            let placeholder = UIImage(named: k.dummyUser)
            cell.userImage.kf.setImage(with: resource, placeholder: placeholder, options: nil, completionHandler: nil)
        }
        
        cell.stackBubble.layer.cornerRadius = 15
        cell.userImage.layer.cornerRadius = 20
        cell.userImage.translatesAutoresizingMaskIntoConstraints = false
        
        return cell
    }
    
    
}

//MARK: - UIImage extensions

extension UIImage {
    func resizeTopAlignedToFill(newWidth: CGFloat) -> UIImage? {
        let newHeight = size.height * newWidth / size.width

        let newSize = CGSize(width: newWidth, height: newHeight)

        UIGraphicsBeginImageContextWithOptions(newSize, false, UIScreen.main.scale)
        draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
