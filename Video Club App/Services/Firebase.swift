//
//  Firebase.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 5/3/21.
//

import Foundation
import Firebase

struct DB {
    
    var docRef: DocumentReference!
    var collRef: CollectionReference!
    var storage = Storage.storage().reference()
    let k = K()
    
    //MARK: - Movies
    mutating func saveMovieToDatabase(_ movie: MovieInfo, _ index: Int) {
        var m: [String: Any]
        m = [
            "title": movie.title,
            "overview": movie.overview,
            "posterImage": k.baseImageUrl + movie.posterImage,
            "year": movie.year,
            "rate": movie.rate,
            "popularity": movie.popularity,
            "secondImage": k.baseImageUrl + movie.secondImg,
            "genre_ids": movie.genres,
            "id": String(movie.id),
            "dbID": String(index)
        ]
        let movieModel = MovieModel()
        movieModel.movies.append(movie)
        docRef = Firestore.firestore().document("Movies/\(String(index))")
        docRef.setData(m) { (error) in
            if let error = error {
                print("Got an error: \(error.localizedDescription)")
            }
        }
        // Delete reviews
        removeReviews(String(index))
    }
    
    mutating func getMoviesFromDatabase(_ movieID: Int, completion: @escaping (_ movie: MovieInfo) -> Void) {
        let movieModel = MovieModel()
        print(movieModel.movies.count)
        docRef = Firestore.firestore().document("Movies/\(String(movieID))")
        docRef.getDocument {(docSnapshot, error) in
            if let docSnapshot = docSnapshot, docSnapshot.exists {
                let myData = docSnapshot.data()
                let id = myData!["id"] as? String ?? ""
                let title = myData!["title"] as? String ?? ""
                let overview = myData!["overview"] as? String ?? ""
                let posterImage = myData!["posterImage"] as? String ?? ""
                let year = myData!["year"] as? String ?? ""
                let rate = myData!["rate"] as? Double ?? 0.0
                let popularity = myData!["popularity"] as? Double ?? 0.0
                let secondImg = myData!["secondImage"] as? String ?? ""
                let genre_ids = myData!["genre_ids"] as? [Int]
                
                let movieItem = MovieInfo(id: Int(id)!, title: title, overview: overview, posterImage: posterImage, year: year, rate: rate, popularity: popularity, secondImg: secondImg, genres: genre_ids!)
                
                completion(movieItem)
            }
        }
    }
    
    //MARK: - Genres
    
    mutating func saveGenreToDatabase(_ genre: GenreInfo) {
        var g: [String: Any]
        g = [
            "id": String(genre.id),
            "name": genre.name
        ]
        docRef = Firestore.firestore().document("Genres/\(String(genre.id))")
        docRef.setData(g) { (error) in
            if let error = error {
                print("Got an error: \(error.localizedDescription)")
            }
        }
    }
    
    mutating func getGenresFromDatabase(_ genre: Int, completion: @escaping (_ genreString: String) -> Void) {
        docRef = Firestore.firestore().document("Genres/\(genre)")
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let myData = document.data()
                let name = myData!["name"] as? String ?? ""

                completion(name)
            }
        }
    }
    
    //MARK: - Reviews
    
    mutating func saveReviewToDatabase(_ review: ReviewInfo, _ movie: String){
        
        var r: [String: Any]
        var avatarImg: String = "Na"
        if let path = review.author.avatar {
            avatarImg = formatPath(path)
        }
        r = [
            "id": review.id,
            "content": String(review.content),
            "author": review.author.user,
            "authorName": review.author.name ?? "",
            "avatar": avatarImg
        ]
        docRef = Firestore.firestore().document("Movies/\(movie)/Reviews/\(review.id)")
        docRef.setData(r) { (error) in
            if let error = error {
                print("Got an error: \(error.localizedDescription)")
            }else{
                print("\(review.author.user)'s review has been saved!")
            }
        }
    }
    
    func removeReviews(_ movieID: String) {
        DispatchQueue.main.async {
            Firestore.firestore().collection("Movies/\(movieID)/Reviews").getDocuments { (snap, err) in
                if let err = err {
                    print("Error pulling reviews to erase: \(err.localizedDescription)")
                }
                for doc in snap!.documents{
                    doc.reference.delete()
                }
            }
        }
    }
    
    mutating func getReviewsFromDatabase(_ id: String, completion: @escaping (_ reviews: [ReviewInfo]) -> Void) {
        var reviews = [ReviewInfo]()
        collRef = Firestore.firestore().collection("Movies/\(id)/Reviews")
        collRef.getDocuments { (document, error) in
            if let document = document {
                for document in document.documents{
                    let data = document.data()
                    let id = data["id"] as? String
                    let user = data["author"] as? String ?? "Anonymus"
                    let name = data["authorName"] as? String ?? " "
                    let avatar = data["avatar"] as? String ?? "Na"
                    let content = data["content"] as? String ?? " "
                    
                    let author = ReviewAuthor(user: user, name: name, avatar: avatar)
                    let review = ReviewInfo(id: id!, content: content, author: author)
                    
                    reviews.append(review)
                }

                completion(reviews)
            }
        }
    }
    
    //MARK: - Images
    
//    func saveImagesToStorage(_ imgName: String, _ image: UIImage) {
//        guard let imageData = image.pngData() else {return}
//
//        let ref = storage.child("images/\(imgName)")
//        ref.putData(imageData, metadata: nil) { (metadata, error) in
//            guard error == nil else {
//                print("Failed to upload: \(error! .localizedDescription)")
//                return
//            }
//        }
//    }
//
//    func saveAvatarImagesToStorage(_ imgString: String){
//        let k = K()
//        let fullPath = k.userImageBase + imgString
//        ic.getImageData(urlString: fullPath, completion: { (image) in
//            saveImagesToStorage(imgString, image)
//        })
//    }
//
    func getImageFromStorage(_ urlString: String) -> UIImage? {
        var image: UIImage?
        let finalPath = formatPath(urlString)
        let ref = storage.child("images/\(finalPath)")
        ref.getData(maxSize: 2 * 1024 * 1024) { (data, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }else{
                image = UIImage(data: data!)
            }
        }
        return image
    }
    
    // Change the format of the avatar path to a general format
    func formatPath(_ path: String) -> String {
        let splitedPath = path.components(separatedBy: "/")
        let finalPath: String = splitedPath[splitedPath.count - 1]
        
        return finalPath
    }
}
