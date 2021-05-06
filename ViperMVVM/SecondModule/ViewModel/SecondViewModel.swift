//
//  SecondViewModel.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 06.05.2021.
//

import Foundation
import RxSwift
import RxCocoa

class SecondViewModel: SecondViewModelProtocol {
    
    private var apiService: APIServiceFirstProtocol
//    var comments: Observable<[SectionModelFirst]> {
//        return reloadComment.asObservable()
//    }
//    private let reloadComment: BehaviorRelay<[SectionModelFirst]>
    
    init(apiService: APIServiceFirstProtocol) {
        self.apiService = apiService
    }
}
