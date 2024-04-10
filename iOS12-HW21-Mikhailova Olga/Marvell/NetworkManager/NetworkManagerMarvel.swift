//
//  NetworkManagerMarvel.swift
//  iOS12-HW21-Mikhailova Olga
//
//  Created by FoxxFire on 10.04.2024.
//

//import Foundation
//import CryptoKit

////MARK: - Error
//
//public enum NetworkError: Error {
//    case requestError
//    case unexpectedHTTPResponse
//    case decodableError
//    case wrongUrl
//}
//
//enum Method: String {
//    case get = "GET"
//    case post = "POST"
//}
//
//func MD5(string: String) -> String {
//    let hash = Insecure.MD5.hash(data: Data(string.utf8))
//
//    return hash.map {
//        String(format: "%02hhx", $0)
//    }.joined()
//}
//
//protocol APIMarvellManagerProtocol: AnyObject {
//    func getComics(completion: @escaping (Result<[Comic], NetworkError>) -> Void)
//}
//
//final class NetworkManagerMarvel: APIMarvellManagerProtocol {
//
//    private lazy var jsonDecoder: JSONDecoder = {
//        JSONDecoder()
//    }()
//
//    private enum URLData {
//        enum Paths: String {
//            case comics = "/v1/public/comics"
//        }
//        static let scheme = "https"
//        static let host = "gateway.marvel.com"
//        static let publicKey = "2956c87f8465a40e730ed3f0234917de"
//        static let privateKey = "ebb15b8cec73e8a4d4c76a1390b2d012df86fad8"
//    }
//
//    private func createURL(paths: URLData.Paths, queryItems: [URLQueryItem]? = nil) -> URL? {
//        var components = URLComponents()
//        components.scheme = URLData.scheme
//        components.host = URLData.host
//        components.path = paths.rawValue
//        components.queryItems = queryItems
//
//        return components.url
//    }
//
//     private func createRequest(url: URL?, method: Method) -> URLRequest? {
//        let ts = String(Date().timeIntervalSince1970)
//        let hash = MD5(string: "\(ts)\(URLData.privateKey)\(URLData.publicKey)")
//        let url = createURL(paths: .comics, queryItems: [URLQueryItem(name: "ts", value: ts), URLQueryItem(name: "apikey", value: URLData.publicKey), URLQueryItem(name: "hash", value: hash)])
//        print(url!)
//        guard let url else { return nil }
//        let request = URLRequest(url: url)
//
//        return request
//    }
//
//    func getComics(completion: @escaping (Result<[Comic], NetworkError>) -> Void) {
//
//        guard let request = createRequest(url: createURL(paths: .comics), method: .get) else { return }
//
//        let task = URLSession.shared.dataTask(with: request) {
//            data, response, error in
//            guard let data else {return}
//            guard let response else {return}
//
//            do {
//                let result = try self.jsonDecoder.decode(ComicDataWrapper.self, from: data)
//                guard let needData = result.data?.results else { return }
//                completion(.success(needData))
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//        task.resume()
//    }
//}
//
