//
//  SongProtocols.swift
//  Arcane
//
//  Created by Владимир on 30.05.23.
//

import UIKit

// MARK: View Input
protocol PresenterToViewMusicProtocol: AnyObject {
    func onFetchSongs(songs: [SongModel])
    func showProgressView()
    func hideProgressView()
    func displaySongImage(image: UIImage?, forSong: SongModel)
}

// MARK: View Output
protocol ViewToPresenterMusicProtocol {
    var view: PresenterToViewMusicProtocol? { get set }
    var interactor: PresenterToInteractorMusicProtocol? { get set }
    var router: PresenterToRouterMusicProtocol? { get set }
    
    func viewDidLoad()
    func numberOfRowsInSection() -> Int
    func songAt(indexPath: IndexPath) -> SongModel
    func selectSongAt(indexPath: IndexPath)
    func searchSongWith(keyword: String)
    func fetchImageForSong(song: SongModel)
}

// MARK: Interactor Input
protocol PresenterToInteractorMusicProtocol {
    var presenter: InteractorToPresenterMusicProtocol? { get set }
    
    func loadSongs()
    func searchSongWith(keyword: String)
    func fetchImageForSong(song: SongModel)
}

// MARK: Interactor Output
protocol InteractorToPresenterMusicProtocol: AnyObject {
    func fetchedSongs(songs: [SongModel])
    func fetchedImage(image: UIImage?, forSong: SongModel)
}

// MARK: Router
protocol PresenterToRouterMusicProtocol {
    static func createModule() -> UINavigationController
    func pushToPlayerScreen(navigationController: UINavigationController, song: SongModel)
}
