//
//  FirstInterfase.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 30.04.2021.
//

import Foundation
import RxSwift

protocol FirstMievModelInputProtocol {
//    func viewDidLoad()
//    func buttonTap()
}

protocol FirstMievModelOutputProtocol {

    var comments: Observable<[Coment]>? { get }
}

protocol FirstViewModelProtocol: FirstMievModelInputProtocol, FirstMievModelOutputProtocol { }
