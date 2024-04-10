//
//  ImageServise.swift
//  iOS12-HW21-Mikhailova Olga
//
//  Created by FoxxFire on 10.04.2024.
//

import UIKit

final class ImageService {
    
    static let cache: NSCache<NSURL, NSData> = {
        let cache = NSCache<NSURL, NSData>()
        cache.countLimit = 20
        return cache
    }()
    
    static let session: URLSession = {
        let session = URLSession(configuration: .default)
        return session
    }()
    
    static func downloadImage(by url: String, completion: @escaping (Result<UIImage, Error>)-> Void) {
        guard let url = URL(string: url) else { return }
        
        let request = URLRequest(url: url)
        
        if let imageData = cache.object(forKey: url as NSURL) {
            if let image = UIImage(data: imageData as Data) {
                completion(.success(image))
            }
        }
        
        session.dataTask(with: request) { data, response, error in

            guard error == nil else {
                print("error")
                return }
            
            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                print("status code")
                return }
            
            guard let data = data else {
                print("data")
                return }

            guard let image = UIImage(data: data) else { return}
            
            cache.setObject(data as NSData, forKey: url as NSURL)
            
            completion(.success(image))
            
        }.resume()
    }
}

