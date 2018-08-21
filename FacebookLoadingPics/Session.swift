//
//  Session.swift
//  FacebookLoadingPics
//
//  Created by Vladimir Kalinichenko on 8/21/18.
//  Copyright © 2018 volody-home. All rights reserved.
//

import Foundation
import UIKit


enum Result<T> {
    case value(T)
    case error
}


class Session {
    let session = URLSession.init(configuration: .default)
    let subdomains: [String]
    init(subdomains: [String]) {
        self.subdomains = subdomains
    }
    
    public func download(images: [String]) {
        for image in images {
            let url = makeURL(for: image)
            download(url: url) { result in
                print("result")
            }
        }
    }
    
    func makeURL(for image: String) -> URL {
        let urlString = "https://\(subdomains[0]).xx.fbcdn.net\(image)"
        return URL(string: urlString)!
    }
    
    func download(url: URL, completion: @escaping (Result<String>) -> ()) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = self.session.dataTask(with: request) { (data, response, error) in
            guard error == nil,
                let data = data,
                let _ = response else {
                    completion(.error)
                    return
            }
            guard let _ = UIImage.init(data: data) else {
                completion(.error)
                return
            }
            self.save(url: url.absoluteString, data: data)
            completion(.value("ok"))
        }
        task.resume()
    }
    
    
    func save(url: String, data: Data) {
        DispatchQueue.global().async {
            let path = url.components(separatedBy: "=").last!
            try? data.write(to: FileManager.default.temporaryDirectory.appendingPathComponent("\(path).jpg"))
        }
    }
    
}
