//
//  FirstViewModel.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 30.04.2021.
//

import Foundation
import RxSwift
import RxCocoa

class FirstViewModel: FirstViewModelProtocol {
    
    private var router: FirstRouter?
    private var apiService: APIServiceFirstProtocol
    var comments: Observable<[SectionModelFirst]> {
        return reloadComment.asObservable()
    }
    private let reloadComment: BehaviorRelay<[SectionModelFirst]>
    
    init(router: FirstRouter, apiService: APIServiceFirstProtocol) {
        self.router = router
        self.apiService = apiService
        
        self.reloadComment = BehaviorRelay<[SectionModelFirst]>(value: [])
        
        self.apiService.getList { [weak self] (comments) in
            switch comments {
            case .success(let comments):
                let sections = comments.posts.map({ coment -> SectionModelFirst in
                    let state = State(isExpanded: false, comment: coment)
                    return SectionModelFirst(header: "Coment", items: [state])
                })
                self?.reloadComment.accept(sections)
                
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func updateExpandedStateForItem(at indexPath: IndexPath) {
      
        var sections = self.reloadComment.value
        var section = sections[indexPath.section]
        section.items[indexPath.row].isExpanded.toggle()
        sections[indexPath.section] = section
        
        self.reloadComment.accept(sections)
    }
}
