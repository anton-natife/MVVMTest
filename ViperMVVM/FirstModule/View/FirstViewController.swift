//
//  FirstViewController.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 30.04.2021.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

final class FirstViewController: UIViewController {
    
    var viewModel: FirstViewModelProtocol!
    var router: FirstRouterProtocol!
    let disposBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    
    lazy var dataSourceFirst: RxTableViewSectionedAnimatedDataSource<SectionModelFirst> = {
        let dataSource = RxTableViewSectionedAnimatedDataSource<SectionModelFirst>(configureCell: { [weak self] (_, tableView, indexPath, item) -> UITableViewCell in
            guard let self = self else { return UITableViewCell() }
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.cellIdentifer, for: indexPath) as? FirstTableViewCell else { return UITableViewCell() }
            
            cell.fill(state: item)
            cell.action
                .subscribe(onNext: { [weak self] in
                    self?.showFullTitleForCell(at: indexPath)
                })
                .disposed(by: cell.disposeBag)
            return cell
        })
        
        dataSource.animationConfiguration = .init(insertAnimation: .right,
                                                  reloadAnimation: .right,
                                                  deleteAnimation: .right)
        return dataSource
    }()
    
    enum Route: String {
              case second
           }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeTable()
        
        self.view.backgroundColor = .black
        
        self.setupNavigationBar()
        self.bindTable()
        
    }
    
    private func customizeTable() {
        self.tableView.register(UINib(nibName: "FirstTableViewCell", bundle: nil), forCellReuseIdentifier: "FirstTableViewCell")
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = .systemGray5
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 44.0
        self.tableView.showsVerticalScrollIndicator = false
        
        self.tableView.delegate = self
    }
    
    // MARK: Bind Table
    func bindTable() {
        self.viewModel.comments
            .observeOn(MainScheduler.instance)
            .bind(to: self.tableView.rx.items(dataSource: self.dataSourceFirst))
            .disposed(by: disposBag)
        
      
    }
    
    private func showFullTitleForCell(at indexPath: IndexPath) {
        self.viewModel.updateExpandedStateForItem(at: indexPath)
        //        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func setupNavigationBar() {
        
        let navigationBar = self.navigationController?.navigationBar
        navigationBar?.barStyle = UIBarStyle.black
        navigationBar?.tintColor = UIColor.white
        //       navigationBar?.barTintColor = .white
        navigationBar?.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        let imageNtife = UIImage(named: "triangle")
        let template = imageNtife?.withRenderingMode(.alwaysTemplate)
        let natifeButton = UIBarButtonItem(image: template, style: .plain, target: self, action: #selector(FirstViewController.tapNatife))
        natifeButton.tintColor = .white
        
        navigationItem.rightBarButtonItem = natifeButton
        
        let label = UILabel()
        label.text = "Главная"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        
        navigationItem.titleView = label
    }
    
    @objc func tapNatife(sender: UIButton) {
        
    }
    
//    func showSecond() {
//            router.route(to: Route.second.rawValue, from: self, parameters: self.viewModel.showCoordinate())
//           }
}

extension FirstViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router.route(to: Route.second.rawValue, from: self, parameters: self.viewModel.getIndex(index: indexPath))
    }
}
