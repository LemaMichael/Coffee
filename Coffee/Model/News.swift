//
//  News.swift
//  Coffee
//
//  Created by Michael Lema on 9/21/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation
import UIKit


struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
}

struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
}

struct Source: Codable {
    let id: String?
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}


class RequestNews {
    
    var articles = [Article]()

    func get(finished: @escaping () -> Void) {
        let filePath = Bundle.main.path(forResource: "Configuration", ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filePath!)
        let apiKEY = plist?.object(forKey: "News API Key") as! String
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKEY)") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                
                let decoder = JSONDecoder()
                let top20News = try decoder.decode(News.self, from: data)
                for article in top20News.articles {
                    if article.urlToImage != nil {
                        self.articles.append(article)
                    }
                }
                finished()
                
            } catch let error as NSError {
                print("error \(error.localizedDescription)")
            }
            }.resume()
    }
}
