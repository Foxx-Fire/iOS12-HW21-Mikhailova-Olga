//
//  ModelMarvell.swift
//  iOS12-HW21-Mikhailova Olga
//
//  Created by FoxxFire on 10.04.2024.
//

import Foundation

// MARK: - Comics
struct ComicDataWrapper: Decodable {
    let code: Int?
    let status: String? // уведомление об авторстве
    let data: ComicDataContainer?  // результаты, возвращаемые вызовом
}

// MARK: - DataClass
struct ComicDataContainer: Decodable {
    let count: Int? // общее количество результатов, возвращенных этим вызовом.
    let results: [Comic]?  // список комиксов, возвращаемых вызовом
}

// MARK: - Result
struct Comic: Decodable {
    let id: Int?  // уникальный идентификатор комиксного ресурса
    let title: String?  // каноническое название комикса
    let textObjects: [TextObject]? // набор описательных текстовых аннотаций для комикса
    let urls: [URLS]?
    let prices: [ComicPrice]?  // список цен на этот комикс
    let thumbnail: Image?  // Репрезентативное изображение этого комикса
    let images: [Image]?
    let creators: CreatorList? // список ресурсов, содержащий создателей, связанных с этим комиксом
    let characters: CharacterList? // список ресурсов, содержащий персонажей, которые появляются в этом комиксе
}

struct URLS: Decodable {
    let type: String?
    let url: String?
}

// MARK: - TextObject

struct TextObject: Decodable {
    let text: String
}

// MARK: - Price

struct ComicPrice: Decodable {
    let price: Float?
}

// MARK: - Thumbnail
struct Image: Decodable {
    let path: String
    let thumbnailExtension: ExtensionIamge

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

enum ExtensionIamge: String, Codable {
    case jpg = "jpg"
}

// MARK: - Creators
struct CreatorList: Decodable {
    let collectionURI: String
    let items: [CreatorSummary]
}

struct CreatorSummary: Decodable {
    let name: String?
}

// MARK: - Characters
struct CharacterList: Decodable {
    let collectionURI: String
}





