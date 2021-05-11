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
    func getIndex(index: IndexPath) -> Int
}

protocol FirstViewModelProtocol: FirstMievModelInputProtocol, FirstMievModelOutputProtocol { }

protocol FirstRouterProtocol {
    func route(to routeID: String, from context: UIViewController, parameters: Int)
}
