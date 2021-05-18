//
//  ImageCache.swift
//  Video Club App
//
//  Created by Rodrigo Camargo on 5/6/21.
//

import UIKit
import RealmSwift
import Network
import Kingfisher

//struct ImageCache {
//    
//    var imageCache = NSCache<NSString, UIImage>()
//    
//    //MARK: - Get, Store and Pull Image from Cache
//    func getImageData(urlString: String, completion: @escaping (_ img: UIImage) -> Void) {
//        getImageFromApi(urlString) { (img) in
//            completion(img)
//        }
//    }
//    
//    //MARK: - Get Images from the API
//    func getImageFromApi(_ urlString: String, completion: @escaping (_ img: UIImage) -> Void){
//        guard let url = URL(string: urlString) else { return }
//        
//        
//        // Check if it exists in the cache
//        let nsUrlString = urlString as NSString
//        if let catchedImage = imageCache.object(forKey: nsUrlString) {
//            completion(catchedImage)
//        }else{
//            let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
//                if let error = error{
//                    print("Error on DataTask: \(error.localizedDescription)")
//                    return
//                }
//                guard let data = data else {
//                    print("No data")
//                    return
//                }
//                
//                DispatchQueue.main.async {
//                    guard let image = UIImage(data: data) else {return}
//                    saveImageToCache(image, nsUrlString)
//                    completion(image)
//                }
//            }
//            task.resume()
//        }
//    }
//    
//    //MARK: - Save an image to the Cache
//    
//    func saveImageToCache(_ image: UIImage, _ key: NSString){
//        imageCache.setObject(image, forKey: key)
//    }
//    
//    //MARK: - Download an image and save it to the Cache
//    
//    func saveImageToCacheAfterDownloading(_ urlString: String){
//        guard let url = URL(string: urlString) else { return }
//        
//        // Check if it exists in the cache
//        let nsUrlString = urlString as NSString
//        if imageCache.object(forKey: nsUrlString) != nil {
//            return
//        }else{
//            let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
//                if let error = error{
//                    print("Error on DataTask: \(error.localizedDescription)")
//                    return
//                }
//                guard let data = data else {
//                    print("No data")
//                    return
//                }
//                
//                DispatchQueue.main.async {
//                    guard let image = UIImage(data: data) else {return}
//                    saveImageToCache(image, nsUrlString)
//                }
//            }
//            task.resume()
//        }
//    }
//    
//}
