//
//  SongService.swift
//  Arcane
//
//  Created by Владимир on 30.05.23.
//

import Foundation

protocol SongServiceProtocol {
    func fetchSongs(keyword: String, completion: @escaping (Result<[SongModel], Error>) -> Void)
}

class SongService: SongServiceProtocol {
    func fetchSongs(keyword: String, completion: @escaping (Result<[SongModel], Error>) -> Void) {
        let baseUrl = "https://itunes.apple.com/search?term="
        let searchUrl = "\(baseUrl)\(keyword.replacingOccurrences(of: " ", with: "+"))"
        
        guard let url = URL(string: searchUrl) else {
            completion(.failure(APIError.invalidURL))
            return
        }
        
        let endpoint = Endpoint(url: url)
        
        APIClient.shared.request(endpoint: endpoint) { (result: Result<SongResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct Endpoint {
    let url: URL?
}



