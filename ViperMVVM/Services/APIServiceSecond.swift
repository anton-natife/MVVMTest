//
//  APIServiceSecond.swift
//  ViperMVVM
//
//  Created by Trainee Alex on 06.05.2021.
//

import Foundation

protocol ImageService {
    func getImage(url: URL, handler: @escaping (Data?) -> Void)
    func getImages(urls: [URL], handler: @escaping ([Data?]) -> Void)
    func downloadImage(url: String) -> Data?
    func loadImagesToFile(url: [String], completion: @escaping (Bool) -> Void)
}

class ImageServiceImplementation {
    
   
}

extension ImageServiceImplementation: ImageService {
    
    func downloadImage(url: String) -> Data? {
        print("\(String(describing: self.loadImageFromDiskWith(fileName: url)))")
            if self.loadImageFromDiskWith(fileName: url) != nil {
                return self.loadImageFromDiskWith(fileName: url)
            } else {
                return nil
            }
        }
    
    func loadImagesToFile(url: [String], completion: @escaping (Bool) -> Void) {
        
        let group = DispatchGroup()
        
        url.forEach { (url) in
            group.enter()
            self.load(URL(string: url)!) { (result) in
                switch result {
                case .success(let data):
                    print("\(data)")
                    if let image = UIImage(data: data) {
                        self.saveImage(name: url, image: image)
                    }
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
    
    func getImage(url: URL, handler: @escaping (UIImage?) -> Void) {
        self.load(url) { (result) in
            switch result {
            case .success(let data):
                handler(UIImage(data: data))
            case .failure( _):
                handler(nil)
            }
        }
    }
    
    func getImages(urls: [URL], handler: @escaping ([UIImage?]) -> Void) {
        var images = [UIImage]()
        urls.forEach { (url) in
            self.load(url) { (result) in
                switch result {
                case .success(let data):
                    images.append(UIImage(data: data)!)
                case .failure(_ ):
                    break
                }
            }
        }
        handler(images)
    }
    
    private func load(_ resource: URL, result: @escaping ((Result<Data>) -> Void)) {
        let request = URLRequest(url: resource)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
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
    
    private func saveImage(name: String, image: Data) {

     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = URL(string: name)?.lastPathComponent ?? name
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data =  //image.jpegData(compressionQuality: 1) else { return }

        //Checks if file exists, removes it if so.
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
    
    private func loadImageFromDiskWith(fileName: String) -> Data? {

        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

          let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
          let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

          if let dirPath = paths.first {
              let filename = URL(string: fileName)?.lastPathComponent ?? fileName
              let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(filename)
              do {
                  let image = try Data(contentsOf: imageUrl)//UIImage(contentsOfFile: imageUrl.path)
                  return image
              } catch {
                  return nil
              }
          }
          return nil
      }
    

}
