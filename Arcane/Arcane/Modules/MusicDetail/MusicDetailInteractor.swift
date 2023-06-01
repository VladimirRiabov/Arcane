//
//  MusicDetailInteractor.swift
//  Arcane
//
//  Created by Владимир on 31.05.23.
//

import Foundation

class MusicDetailInteractor: PresenterToInteractorMusicDetailProtocol {
    var imageService: ImageServiceProtocol = ImageService()
    
    weak var presenter: InteractorToPresenterMusicDetailProtocol?
    var song: SongModel?
    
    func fetchSongDetail() {
        if let song = song {
            presenter?.fetchedSongDetail(song: song)
        }
    }
    
    func fetchSongImage(from url: URL) {
        imageService.loadImage(from: url) { image in
            self.presenter?.fetchedSongImage(image: image)
        }
    }
}
