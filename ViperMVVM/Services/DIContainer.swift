//
//  DIContainer.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 30.04.2021.
//

import Foundation

class DIContainer {
    static var shared = DIContainer()
    
    lazy var apiServiceFirst: APIServiceFirstProtocol = APIServiceFirstImplementation()
    lazy var imageServis: ImageService = ImageServiceImplementation()
}

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum APIError: Error {
    case noData
}
