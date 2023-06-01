//
//  MusicInteractor.swift
//  Arcane
//
//  Created by Владимир on 30.05.23.
//

import Foundation

class MusicInteractor: PresenterToInteractorMusicProtocol {
    var imageService: ImageServiceProtocol = ImageService()
    
    weak var presenter: InteractorToPresenterMusicProtocol?
    private var songService: SongServiceProtocol?
    
    init() {
        self.songService = SongService()
    }
    
    func loadSongs() {
        let initialKeyword = "trending"
        
        songService?.fetchSongs(keyword: initialKeyword, completion: { result in
            switch result {
            case .success(let songs):
                self.presenter?.fetchedSongs(songs: songs)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    func fetchImageForSong(song: SongModel) {
        guard let artworkUrlString = song.artworkUrl100, let artworkUrl = URL(string: artworkUrlString) else {
            presenter?.fetchedImage(image: nil, forSong: song)
            return
        }
        
        imageService.loadImage(from: artworkUrl, completion: { [weak self] image in
            self?.presenter?.fetchedImage(image: image, forSong: song)
        })
    }
    
    
    func searchSongWith(keyword: String) {
        songService?.fetchSongs(keyword: keyword, completion: { result in
            switch result {
            case .success(let songs):
                self.presenter?.fetchedSongs(songs: songs)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

