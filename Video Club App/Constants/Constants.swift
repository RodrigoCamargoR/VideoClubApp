//
//  Constants.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 4/23/21.
//

struct Constants {
    
    //MARK: - API Data
    let apiKey: String = "api_key=2bd0308b0c46908511f36317946b9053"
    let apiUrl: String = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc"
    let baseImageUrl: String = "https://www.themoviedb.org/t/p/w440_and_h660_face"
    let genreApiURL: String = "https://api.themoviedb.org/3/genre/movie/list?language=en-US"
    let reviewsURL: String = "https://api.themoviedb.org/3/movie/"
    
    //MARK: - Collection View Cell
    let cvcIndentifier = "CollectionViewCell"
    
    //MARK: - Review Table
    let reviewCell = "ReviewCell"
    let cellIdentifier = "ReviewReusableCell"
    let userImageBase = "https://secure.gravatar.com/avatar/"
    
    //MARK: - Image names
    let dummyUser = "dummyUser"
    let noPosterAvailable = "NoImageAvailable"
    
    //MARK: - Offline Mode
    /* The value below is expressed in hours, so if the value = 24, the data will be
     deleted when the user opens the app 1 day after the last connection */
    let connectionHours : Double = 24
    
    let alertTitle = "No Internet Connection"
    let alertBody = "No movies were found because you're not connected to a Network. Please close the app, try connecting to a network and try again"
    
}
