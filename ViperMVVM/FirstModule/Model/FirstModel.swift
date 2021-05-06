//
//  FirstModel.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 30.04.2021.
//

import Foundation
import RxDataSources

struct FailableDecoder<Base: Decodable> : Decodable {
    var base: Base?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}

struct Coments: Decodable {
    var posts: [Coment]
    
    enum CodingKeys: String, CodingKey {
        case posts
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        posts = try container.decode([FailableDecoder<Coment>].self,
                                     forKey: .posts).compactMap { $0.base }
        
    }
}

struct Coment: Codable {
    var postId: Int
    var timeshamp: Double?
    var title: String?
    var previewText: String?
    var likesCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case postId
        case timeshamp
        case title
        case previewText = "preview_text"
        case likesCount = "likes_count"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        //        postId = try container.decode(Int.self, forKey: .postId)
        timeshamp = try container.decode(Double.self, forKey: .timeshamp)
        title = try container.decode(String.self, forKey: .title)
        previewText = try container.decode(String.self, forKey: .previewText)
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
        try container.encode(previewText, forKey: .previewText)
        try container.encode(likesCount, forKey: .likesCount)
    }
    
    enum ErrorType: Error {
        case decodeError
    }
    
}

struct SectionModelFirst {
    var header: String!
    var items: [Item]
}

extension SectionModelFirst: AnimatableSectionModelType, Hashable {
    typealias Item  = State
    var identity: String {
        return "\(hashValue)"
    }
    
    init(original: SectionModelFirst, items: [Item]) {
        self = original
        self.items = items
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(header)
        items.forEach({ item in
            hasher.combine(item.identity)
        })
    }
}
