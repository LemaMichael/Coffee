//
//  SMMRY.swift
//  Coffee
//
//  Created by Michael Lema on 9/23/18.
//  Copyright © 2018 Michael Lema. All rights reserved.
//

import Foundation

struct Smmry: Codable {
    let smAPICharacterCount: String
    let smAPIContentReduced: String
    let smAPITitle: String
    let smAPIContent: String
    let smAPILimitation: String
    
    enum CodingKeys: String, CodingKey {
        case smAPICharacterCount = "sm_api_character_count"
        case smAPIContentReduced = "sm_api_content_reduced"
        case smAPITitle = "sm_api_title"
        case smAPIContent = "sm_api_content"
        case smAPILimitation = "sm_api_limitation"
    }
}

class Summary {
    
    var content = String()
    
    func get(url: String, finished: @escaping () -> Void) {
        
        let filePath = Bundle.main.path(forResource: "Configuration", ofType: "plist")
        let plist = NSDictionary(contentsOfFile: filePath!)
        let apiKEY = plist?.object(forKey: "SMMRY API Key") as! String
        
        // Changing summary length to 5 sentences
        guard let url = URL(string: "https://api.smmry.com/SM_API_KEY=\(apiKEY)&SM_WITH_BREAK&SM_URL=\(url)#&SM_LENGTH=5") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                let decoder = JSONDecoder()
                let summary = try decoder.decode(Smmry.self, from: data)
                self.content = summary.smAPIContent
                print(summary.smAPILimitation)
                print(summary.smAPIContent)
                print("\n")
                finished()
            } catch let error as NSError {
                print("error \(error.localizedDescription)")
            }
            
            }.resume()
    }
    
    func getContent() -> String {
        return content
    }
}
