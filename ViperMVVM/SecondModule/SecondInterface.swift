//
//  SecondInterface.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 06.05.2021.
//

import Foundation
import RxSwift

protocol SecondMievModelInputProtocol {
}

protocol SecondMievModelOutputProtocol {
    var data: Observable<[SectionModelSecond]> { get }
    var dataLabel: Observable<String> { get }
}

protocol SecondViewModelProtocol: SecondMievModelInputProtocol, SecondMievModelOutputProtocol {
}
