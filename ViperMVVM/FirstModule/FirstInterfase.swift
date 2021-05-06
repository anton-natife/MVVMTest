//
//  FirstInterfase.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 30.04.2021.
//

import Foundation
import RxSwift

protocol FirstMievModelInputProtocol {
    func updateExpandedStateForItem(at indexPath: IndexPath)
}

protocol FirstMievModelOutputProtocol {

    var comments: Observable<[SectionModelFirst]> { get }
}

protocol FirstViewModelProtocol: FirstMievModelInputProtocol, FirstMievModelOutputProtocol { }

protocol FirstRouterProtocol {
    
}
