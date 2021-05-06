//
//  SecondWireFrame.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 06.05.2021.
//

import UIKit

class SecondWireFrame {
    
    static func create() -> UIViewController {
        
        let view = SecondViewController()
        let apiservice = DIContainer.shared.apiServiceFirst
        let viewModel = SecondViewModel(apiService: apiservice)
        view.viewModel = viewModel
        
        return view
    }
}
