//
//  APIServiceFirst.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 30.04.2021.
//

import Foundation

protocol APIServiceFirstProtocol {
    func getList(handler: @escaping (Result<Coments>) -> Void)
//    func getComent(index: Int, handler: @escaping (Result<CurentComents>) -> Void)
    func getListWithId(myId: Int, handler: @escaping (Result<Coments>) -> Void)
}

class APIServiceFirstImplementation {
    
    let session = URLSession.shared
    //https://raw.githubusercontent.com/aShaforostov/jsons/master/api/main.json
    //https://raw.githubusercontent.com/aShaforostov/jsons/master/api/posts/[112].json
    //https://raw.githubusercontent.com/aShaforostov/jsons/master/api/feed/3.json
    
    let baseURL: URL = URL(string: "https://raw.githubusercontent.com/aShaforostov/jsons/master/api")!
    fileprivate enum Endpoint {
        case list
        case feed(Int)
        
        var path: String {
            switch self {
            case .list:
                return "main.json"
            case .feed(let page):
                return "feed/\(page).json"
            }
        }
    }
}

extension APIServiceFirstImplementation: APIServiceFirstProtocol {
    
    func getList(handler: @escaping (Result<Coments>) -> Void) {
        let targetURL = baseURL.appendingPathComponent(Endpoint.list.path)
        self.load(targetURL) { (result) in
            
            switch result {
            case .success(let data):
                do {
                    let parsedResult: Coments = try JSONDecoder().decode(Coments.self, from: data)
                    handler(.success(parsedResult))
                } catch let error {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    func getListWithId(myId: Int, handler: @escaping (Result<Coments>) -> Void) {
        let targetUrl = baseURL.appendingPathComponent(Endpoint.list.path)
        self.load(targetUrl) { (result) in
            switch result {
            case .success(let data):
                
                do {
                    let parsedResult: Coments = try JSONDecoder().decode(Coments.self, from: data)
                    handler(.success(parsedResult))
                } catch let error {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
//    func getComent(index: Int, handler: @escaping (Result<CurentComents>) -> Void) {
//        let targetURL = baseURL.appendingPathComponent(Endpoint.post(index).path)
//        self.load(targetURL) { (result) in
//
//            switch result {
//            case .success(let data):
//                do {
//                    let parsedResult: CurentComents = try JSONDecoder().decode(CurentComents.self, from: data)
//                    handler(.success(parsedResult))
//                } catch let error {
//                    handler(.failure(error))
//                }
//            case .failure(let error):
//                handler(.failure(error))
//            }
//        }
//    }
    
    private func load(_ resource: URL, result: @escaping ((Result<Data>) -> Void)) {
        let request = URLRequest(url: resource)
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            guard let data = data else {
                result(.failure(APIError.noData))
                return
            }
            if let error = error {
                result(.failure(error))
                return
            }
            result(.success(data))
        }
        task.resume()
    }

}
