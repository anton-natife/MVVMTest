//
//  APIServiceSecond.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 06.05.2021.
//

import Foundation

protocol ImageServiceProtocol {
//    func getImage(url: URL, handler: @escaping (Data?) -> Void)
//    func getImages(urls: [URL], handler: @escaping ([Data]?) -> Void)
    func getComent(index: Int, handler: @escaping (Result<CurentComents>) -> Void)
    func downLoadImage(url: [String], completion: @escaping ([Data]?) -> Void)
}

class ImageServiceImplementation {
    
    let baseURL: URL = URL(string: "https://raw.githubusercontent.com/aShaforostov/jsons/master/api")!
    fileprivate enum Endpoint {
    
        case post(Int)
        
        var path: String {
            switch self {
            case .post(let myId):
                return "posts/\(myId).json"
            }
        }
    }
}

extension ImageServiceImplementation: ImageServiceProtocol {
    
    func getComent(index: Int, handler: @escaping (Result<CurentComents>) -> Void) {
        let targetURL = baseURL.appendingPathComponent(Endpoint.post(index).path)
        self.load(targetURL) { (result) in
            
            switch result {
            case .success(let data):
                do {
                    let parsedResult: CurentComents = try JSONDecoder().decode(CurentComents.self, from: data)
                    handler(.success(parsedResult))
                    
//                    guard let images = parsedResult.post.images, images.count > 0 else { return }
//                    self.loadImagesToFile(url: images) { (success) in
//                        if success {
//                            var images: [Data] = []
//                            parsedResult.post.images?.forEach({ (image) in
//                                guard let image = self.downloadImage(url: image) else { return }
//                                images.append(image)
//                            })
//                            let
//
 //                       }
//                    }
                    
                } catch let error {
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        }
    }
    
    func downLoadImage(url: [String], completion: @escaping ([Data]?) -> Void) {
        self.loadImagesToFile(url: url) { (success) in
            var images: [Data] = []
            url.forEach { (image) in
                guard let image = self.downloadImage(url: image) else { return }
                images.append(image)
            }
           completion(images)
        }
    }
    
    func downloadImage(url: String) -> Data? {
        print("\(String(describing: self.loadDataFromDiskWith(fileName: url)))")
            if self.loadDataFromDiskWith(fileName: url) != nil {
                return self.loadDataFromDiskWith(fileName: url)
            } else {
                return nil
            }
        }
    
    private func loadImagesToFile(url: [String], completion: @escaping (Bool) -> Void) {
        
        let group = DispatchGroup()
        
        url.forEach { (url) in
            group.enter()
            self.load(URL(string: url)!) { (result) in
                switch result {
                case .success(let data):
                        self.saveImage(name: url, data: data)
                case .failure( let error):
                    print("\(error)")
                }
                group.leave()
            }
            
        }
        
        group.notify(queue: DispatchQueue.global()) {
            completion(true)
          }
    }
    
    func getImage(url: URL, handler: @escaping (Data?) -> Void) {
        self.load(url) { (result) in
            switch result {
            case .success(let data):
                handler(data)
            case .failure(let error):
                print("\(error.localizedDescription)")
                handler(nil)
            }
        }
    }
    
    func getImages(urls: [URL], handler: @escaping ([Data]?) -> Void) {
        var images = [Data]()
        urls.forEach { (url) in
            self.load(url) { (result) in
                switch result {
                case .success(let data):
                    images.append(data)
                case .failure(let error):
                    print("\(error.localizedDescription)")
                    handler(nil)
                }
            }
        }
        handler(images)
    }
    
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
    
    private func saveImage(name: String, data: Data) {

     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = URL(string: name)?.lastPathComponent ?? name
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
 
        // Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }

        }

        do {
            try data.write(to: fileURL)
            print("\(fileURL)")
        } catch let error {
            print("error saving file with error", error)
        }

    }
    
    private func loadDataFromDiskWith(fileName: String) -> Data? {

        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

          let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
          let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

          if let dirPath = paths.first {
              let filename = URL(string: fileName)?.lastPathComponent ?? fileName
              let dataUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(filename)
              do {
                  let data = try Data(contentsOf: dataUrl) // UIImage(contentsOfFile: imageUrl.path)
                  return data
              } catch {
                  return nil
              }
          }
          return nil
      }
}
