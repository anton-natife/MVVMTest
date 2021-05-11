//
//  SecondViewController.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 06.05.2021.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

class SecondViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: SecondViewModelProtocol!
    let disposBag = DisposeBag()
    private var titlelabel: UILabel?
    
    var dataSourceSecond: RxTableViewSectionedReloadDataSource<SectionModelSecond>!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.titlelabel = UILabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black

        self.customizeTable()
        self.createDataSource()
        self.customizeNavigation()
        self.bindUI()
    }
    
}

extension SecondViewController {
    private func customizeTable() {
        
        self.tableView.register(UINib(nibName: "TableViewCellTitle", bundle: nil), forCellReuseIdentifier: "Title")
        self.tableView.register(UINib(nibName: "TableViewCellDescription", bundle: nil), forCellReuseIdentifier: "Description")
        self.tableView.register(UINib(nibName: "TableViewCellImage", bundle: nil), forCellReuseIdentifier: "Image")
        self.tableView.register(UINib(nibName: "TableViewCellHurts", bundle: nil), forCellReuseIdentifier: "Heart")
        self.tableView.separatorStyle = .none
        self.tableView.showsVerticalScrollIndicator = false
    }
    
    private func customizeNavigation() {
        
        self.titlelabel?.text = "SecondVC"
        self.titlelabel?.font = UIFont.boldSystemFont(ofSize: 25)
        self.titlelabel?.textColor = .white
        self.titlelabel?.translatesAutoresizingMaskIntoConstraints = false
        self.titlelabel?.widthAnchor.constraint(equalToConstant: self.view.bounds.size.width / 3 * 2).isActive = true
        
        navigationItem.titleView = self.titlelabel
        
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        backButton.tintColor = .white
        self.navigationController?.navigationBar.topItem!.backBarButtonItem = backButton
    }
    
    private func bindUI() {
        
        self.viewModel.data
                    .observeOn(MainScheduler.instance)
                    .bind(to: self.tableView.rx.items(dataSource: self.dataSourceSecond))
                    .disposed(by: disposBag)
        
        self.viewModel.dataLabel.bind(to: self.titlelabel!.rx.text)
            .disposed(by: disposBag)
    }
    
    private func createDataSource() {
    
    self.dataSourceSecond = RxTableViewSectionedReloadDataSource<SectionModelSecond>(configureCell: { [weak self] (_, tableView, indexPath, item) -> UITableViewCell in
            
                switch item {
                case .title(let title):
                    
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "Title", for: indexPath) as? TableViewCellTitle else { return UITableViewCell() }
                    
                    cell.configure(title: title ?? "")
                    return cell
                case .text(let text):
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "Description", for: indexPath) as? TableViewCellDescription else { return UITableViewCell() }
                    cell.configure(description: text ?? "")
                    return cell
                case .image(let data):
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "Image", for: indexPath) as? TableViewCellImage else { return UITableViewCell() }
                    cell.configure(data: data, width: self?.view.frame.width)
                    // cell.configure(image, self.view.frame.width)
                    return cell
                case .footer(hurts: let hurts, time: let time):
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: "Heart", for: indexPath) as? TableViewCellHurts else { return UITableViewCell() }
                    cell.configure(countHurt: hurts, time: time)
                    return cell
                }
        })
    }
}
