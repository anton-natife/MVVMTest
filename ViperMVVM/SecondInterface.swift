//
//  SecondInterface.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 06.05.2021.
//

import Foundation
import RxSwift

protocol SecondMievModelInputProtocol {
//    func updateExpandedStateForItem(at indexPath: IndexPath)
}

protocol SecondMievModelOutputProtocol {

//    var comments: Observable<[SectionModelFirst]> { get }
}

protocol SecondViewModelProtocol: SecondMievModelInputProtocol, SecondMievModelOutputProtocol { }

