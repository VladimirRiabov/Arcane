//
//  ImageService.swift
//  Arcane
//
//  Created by Владимир on 01.06.23.
//

import UIKit

protocol ImageServiceProtocol {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void)
}

class ImageService: ImageServiceProtocol {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error in downloading image: \(String(describing: error))")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                completion(image)
            }
        }
        dataTask.resume()
    }
}
