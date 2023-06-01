//
//  MusicDetailPresenter.swift
//  Arcane
//
//  Created by Владимир on 31.05.23.
//

import UIKit

class MusicDetailPresenter: ViewToPresenterMusicDetailProtocol, InteractorToPresenterMusicDetailProtocol {
    
    weak var view: PresenterToViewMusicDetailProtocol?
    var interactor: PresenterToInteractorMusicDetailProtocol?
    var router: PresenterToRouterMusicDetailProtocol?
    var song: SongModel?
    
    func viewDidLoad() {
        guard let song = song else {
            return
        }
        view?.displaySongDetail(song: song)
    }
    
    func fetchedSongDetail(song: SongModel) {
        view?.displaySongDetail(song: song)
    }
    
    
    func loadSongImage(from url: URL) {
        interactor?.fetchSongImage(from: url)
    }
    
    func fetchedSongImage(image: UIImage?) {
        view?.displaySongImage(image: image)
    }
}
