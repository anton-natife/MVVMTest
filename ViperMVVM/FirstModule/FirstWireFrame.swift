//
//  FirstWireFrame.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 30.04.2021.
//

import UIKit

class FirstWireFrame {
    
    static func create() -> UIViewController {
        
        let view = FirstViewController()
        let apiservice = DIContainer.shared.apiServiceFirst
        let router = FirstRouter(controller: view)
        let viewModel = FirstViewModel(router: router, apiService: apiservice)
        view.viewModel = viewModel
        
        return view
    }
}
