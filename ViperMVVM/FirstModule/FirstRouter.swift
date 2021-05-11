//
//  FirstRouter.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 30.04.2021.
//

import Foundation
import UIKit

class FirstRouter {
    
    private weak var controller: FirstViewController?
    
    init(controller: FirstViewController?) {
        self.controller = controller
    }
}

extension FirstRouter: FirstRouterProtocol {
   
    func route(to routeID: String, from context: UIViewController, parameters: Int) {
          guard let route = FirstViewController.Route(rawValue: routeID) else {
             return
          }
          switch route {
          case .second:
           context.navigationController?.pushViewController( SecondWireFrame.create(index: parameters), animated: true)
          }
       }
}
