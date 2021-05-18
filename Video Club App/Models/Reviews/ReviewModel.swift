//
//  ReviewModel.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 5/3/21.
//

import Foundation

class ReviewModel {
    private var reviewManager = ReviewManager()
    private var realm = RealmDatabase()
    var reviews = [ReviewInfo]()
    
    func fetchReviews(_ id: String, _ index: String){
        reviewManager.getReviews(id, completion: { (listOf, error) in
            if error == nil {
                self.reviews = listOf!.reviews
                // Remove reviews from database
                self.realm.deleteReviewsFromMovie(index)
                // Save to movies to database
                for review in self.reviews{
                    self.realm.saveReview(review, index)
                }
            }else{
                print("There was an error when processing Json data: \(error!)")
            }
        })
    }
    
    // Change the format of the avatar path to a general format
    func formatAvatarPath(_ path: String) -> String {
        let splitedPath = path.components(separatedBy: "/")
        let finalPath: String = splitedPath[splitedPath.count - 1]
        
        return finalPath
    }
    
}
