//
//  MusicPresenter.swift
//  Arcane
//
//  Created by Владимир on 30.05.23.
//

import UIKit

class MusicPresenter: ViewToPresenterMusicProtocol {
    
    weak var view: PresenterToViewMusicProtocol?
    var interactor: PresenterToInteractorMusicProtocol?
    var router: PresenterToRouterMusicProtocol?
    
    var songs: [SongModel] = []
    
    func viewDidLoad() {
        loadSongs()
    }
    
    func loadSongs() {
        interactor?.loadSongs()
    }
    
    func numberOfRowsInSection() -> Int {
        return songs.count
    }
    
    func songAt(indexPath: IndexPath) -> SongModel {
        return songs[indexPath.row]
    }
    
    func selectSongAt(indexPath: IndexPath) {
        let song = self.songAt(indexPath: indexPath)
        if let view = view as? UIViewController, let navigationController = view.navigationController {
            router?.pushToPlayerScreen(navigationController: navigationController, song: song)
        }
    }
    
    func searchSongWith(keyword: String) {
        if keyword.count < 3 {
        } else {
            interactor?.searchSongWith(keyword: keyword)
        }
    }
}

extension MusicPresenter: InteractorToPresenterMusicProtocol {
    func fetchedImage(image: UIImage?, forSong: SongModel) {
        view?.displaySongImage(image: image, forSong: forSong)
    }
    
    func fetchImageForSong(song: SongModel) {
        interactor?.fetchImageForSong(song: song)
    }
    
    func fetchedSongs(songs: [SongModel]) {
        self.songs = songs
        if songs.isEmpty {
            view?.showProgressView()
        } else {
            view?.hideProgressView()
            view?.onFetchSongs(songs: songs)
        }
    }
}
