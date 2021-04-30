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
    var comments: Observable<[Coment]>?
    
    init(router: FirstRouter, apiService: APIServiceFirstProtocol) {
        self.router = router
        self.apiService = apiService
        
        let comentsV = BehaviorRelay<[Coment]>(value: [])
        
        self.comments = comentsV.asObservable()
        self.apiService.getList { (comments) in
            switch comments {
            case .success(let comments):
                comentsV.accept(comments.posts)
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
        
    }
    
}
