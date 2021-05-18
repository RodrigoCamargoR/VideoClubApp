//
//  ApiManager.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 5/2/21.
//

import Foundation

struct MoviesApi {
    private var dataTask: URLSessionDataTask?
    let k = K()
    
//MARK: - Fetch the movies from the API
    
    mutating func getMovies(completion: @escaping (Result<MovieData, Error>) -> Void) {
        guard let url = URL(string: k.apiUrl + "&" + k.apiKey) else { return }
        
        // Create URL Session
        dataTask = URLSession.shared.dataTask(with: url){(data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }
            
            // Check if response is empty
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            // Check if data is empty
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                // Parse Json pulled from the API
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(MovieData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error{
                completion(.failure(error))
                print("Error on parsing Json")
            }
        }
        dataTask?.resume()
    }
    
    
    //MARK: - Get the Movie Genres from the API
    
    mutating func getMovieGenres(completion: @escaping (Result<GenreData, Error>) -> Void){
        guard let url = URL(string: k.genreApiURL + "&" + k.apiKey) else { return }
        
        // Create URL Session
        dataTask = URLSession.shared.dataTask(with: url){(data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                print("DataTask error: \(error.localizedDescription)")
                return
            }

            // Check if response is empty
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            // Check if data is empty
            guard let data = data else {
                print("Empty Data")
                return
            }
            
            do {
                // Parse Json pulled from the API
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(GenreData.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }catch let error{
                completion(.failure(error))
                print("Error on parsing Json")
            }
        }
        dataTask?.resume()
    }
    
    //MARK: - Fetch the reviews from the API
        
    mutating func getReviews(_ movieID: String, completion: @escaping (Result<ReviewData, Error>) -> Void) {
            guard let url = URL(string: k.reviewsURL + "\(movieID)/reviews?" + k.apiKey) else { return }
            
            // Create URL Session
            dataTask = URLSession.shared.dataTask(with: url){(data, response, error) in
                
                if let error = error {
                    completion(.failure(error))
                    print("DataTask error: \(error.localizedDescription)")
                    return
                }
                
                // Check if response is empty
                guard let response = response as? HTTPURLResponse else {
                    print("Empty Response")
                    return
                }
                print("Response status code: \(response.statusCode)")
                
                // Check if data is empty
                guard let data = data else {
                    print("Empty Data")
                    return
                }
                
                do {
                    // Parse Json pulled from the API
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(ReviewData.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(.success(jsonData))
                    }
                }catch let error{
                    completion(.failure(error))
                    print("Error on parsing Json")
                }
            }
            dataTask?.resume()
        }
    
}
