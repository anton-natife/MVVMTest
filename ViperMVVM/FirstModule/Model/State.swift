//
//  State.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 05.05.2021.
//

import Foundation
import RxDataSources

struct State: IdentifiableType, Equatable, Hashable {
    typealias Identity = Int
    
    var identity: Int {
        self.hashValue
    }
    
    static func == (lhs: State, rhs: State) -> Bool {
        return lhs.identity == rhs.identity
    }
    
    var isExpanded: Bool
    let comment: Coment
    
    init(isExpanded: Bool = false, comment: Coment) {
        self.isExpanded = isExpanded
        self.comment = comment
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(isExpanded)
        hasher.combine(comment.postId)
        hasher.combine(comment.likesCount)
        hasher.combine(comment.previewText)
        hasher.combine(comment.timeshamp)
        hasher.combine(comment.title)
    }
}
