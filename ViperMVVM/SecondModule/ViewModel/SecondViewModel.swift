//
//  SecondViewModel.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 06.05.2021.
//

import Foundation
import RxSwift
import RxCocoa

class SecondViewModel: SecondViewModelProtocol {
    
    private var apiService: ImageServiceProtocol
//    var data: Observable<[SectionModelSecond]>
    var data: Observable<[SectionModelSecond]> {
        return reloadData.asObservable()
    }
    private let reloadData: BehaviorRelay<[SectionModelSecond]>
    
    init(index: Int, apiService: ImageServiceProtocol) {
        self.apiService = apiService
        self.reloadData = BehaviorRelay<[SectionModelSecond]>(value: [])
 
        var dataSource: [ComentId] = []
        
        self.apiService.getComent(index: index) { [weak self] (coments) in
            switch coments {
            case .success(let coments):
                dataSource.append(.title(coments.post.title))
                dataSource.append(.text(coments.post.text))
                
                guard let data = coments.post.images else { break }
                self?.apiService.downLoadImage(url: data) { (images) in
                    guard let images = images else { return }
                    images.forEach { (data) in
                        dataSource.append(.image(data))
                    }
                   
                    dataSource.append(.footer(hurts: coments.post.likesCount.description, time: self?.createTime(time: coments.post.timeshamp) ?? "now"))
                    
                    self?.reloadData.accept([SectionModelSecond(header: "Comment", items: dataSource)])
                }
                
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
    
    private func createTime(time: Double) -> String {
        
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        let strTime = dateFormatter.string(from: date)
        return strTime
    }
}
