//
//  NetworkManagerAF.swift
//  iOS12-HW21-Mikhailova Olga
//
//  Created by FoxxFire on 10.04.2024.
//

import Alamofire
import CryptoKit
import Foundation

protocol APIMarvellManagerProtocol: AnyObject {
    func getComics(completion: @escaping (Result<[Comic], Error>) -> Void)
}

//MARK: - Error

public enum NetworkError: Error {
    case requestError
    case unexpectedHTTPResponse
    case decodableError
    case wrongUrl
    case invalidData
}

enum Method: String {
    case get = "GET"
    case post = "POST"
}

func MD5(string: String) -> String {
    let hash = Insecure.MD5.hash(data: Data(string.utf8))

    return hash.map {
        String(format: "%02hhx", $0)
    }.joined()
}

final class NetworkManagerAF: APIMarvellManagerProtocol {
    
    private enum URLData {
        enum Paths: String {
            case comics = "/v1/public/comics"
        }
        static let scheme = "https"
        static let host = "gateway.marvel.com"
        static let publicKey = "2956c87f8465a40e730ed3f0234917de"
        static let privateKey = "ebb15b8cec73e8a4d4c76a1390b2d012df86fad8"
    }
    
    private func createURL(paths: URLData.Paths, queryItems: [URLQueryItem]? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = URLData.scheme
        components.host = URLData.host
        components.path = paths.rawValue
        components.queryItems = queryItems
        
        return components.url
    }
    
    func getComics(completion: @escaping (Result<[Comic], Error>) -> Void) {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(ts)\(URLData.privateKey)\(URLData.publicKey)")
        let url = createURL(paths: .comics, queryItems: [URLQueryItem(name: "ts", value: ts), URLQueryItem(name: "apikey", value: URLData.publicKey), URLQueryItem(name: "hash", value: hash)])
        guard let url else { completion(.failure(NetworkError.wrongUrl))
            return
        }
        
        AF.request(url)
            .validate()
            .response { response in
                guard let data = response.data else {
                    if let error = response.error {
                        completion(.failure(error.localizedDescription as! Error))
                    }
                    return
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                guard let userResults = try? decoder.decode(ComicDataWrapper.self, from: data) else {
                    completion(.failure(NetworkError.invalidData))
                    return
                }
                guard let needData = userResults.data?.results else { return }
                completion(.success(needData))
            }
    }
}
    
