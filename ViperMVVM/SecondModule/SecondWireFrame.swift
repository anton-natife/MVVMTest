//
//  SecondWireFrame.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 06.05.2021.
//

import UIKit

class SecondWireFrame {
    
    static func create(index: Int) -> UIViewController {
        
        let view = SecondViewController()
        let apiservice = DIContainer.shared.imageServis
        let viewModel = SecondViewModel(index: index, apiService: apiservice)
        view.viewModel = viewModel
        
        return view
    }
}
