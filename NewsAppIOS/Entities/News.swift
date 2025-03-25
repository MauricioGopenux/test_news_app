//
//  News.swift
//  NewsAppIOS
//
//  Created by Radmas on 21/03/25.
//
struct News: Decodable {
    var imageURL: String?
    var title: String?
    var description: String?
    var favorite: Bool!
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageURL = "urlToImage"
    }
}



