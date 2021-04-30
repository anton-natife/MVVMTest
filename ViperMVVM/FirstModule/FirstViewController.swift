//
//  FirstViewController.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 30.04.2021.
//

import UIKit

final class FirstViewController: UIViewController {
    
    var viewModel: FirstViewModelProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.tableView.dataSource = self
//        self.tableView.delegate = self

//        self.tableView.backgroundColor = .systemRed
    }
    
    private func bindUI() {
        
    }

}

//extension FirstViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//    }
//
//
//}
//
//extension FirstViewController: UITableViewDelegate {
//
//}
