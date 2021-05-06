//
//  SecondModel.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 30.04.2021.
//

import Foundation

struct CurentComents: Codable {
    var post: CurentComent
}

struct CurentComent: Codable {
    var postId: Int
    var timeshamp: Double
    var title: String?
    var text: String?
    var images: [String]?
    var likesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case postId
        case timeshamp
        case title
        case text
        case images
        case likesCount = "likes_count"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        timeshamp = try container.decode(Double.self, forKey: .timeshamp)
        title = try container.decode(String.self, forKey: .title)
        text = try container.decode(String.self, forKey: .text)
        images = try container.decode([String].self, forKey: .images)
        likesCount = try container.decode(Int.self, forKey: .likesCount)
        
        // First check for a Int
        do {
            if let miId = try? container.decode(Int.self, forKey: .postId) {
                postId = miId
            } else {
                throw ErrorType.decodeError
            }
            
        } catch {
            print("catch")
            
            if let typeValue = Int(try container.decode(String.self, forKey: .postId)) {
                postId = typeValue
            } else {
                throw ErrorType.decodeError
            }
        }
    }
   
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(postId, forKey: .postId)
        try container.encode(timeshamp, forKey: .timeshamp)
        try container.encode(title, forKey: .title)
        try container.encode(text, forKey: .text)
        try container.encode(images, forKey: .images)
        try container.encode(likesCount, forKey: .likesCount)
    }
    
    enum ErrorType: Error {
        case decodeError
    }
    
}
