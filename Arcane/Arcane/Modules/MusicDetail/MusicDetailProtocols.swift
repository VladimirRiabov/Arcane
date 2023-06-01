//
//  MusicDetailProtocols.swift
//  Arcane
//
//  Created by Владимир on 31.05.23.
//

import UIKit

// MARK: Router
protocol PresenterToRouterMusicDetailProtocol: AnyObject {
    static func createMusicDetailModule(with song: SongModel) -> MusicDetailViewController
}

// MARK: View Input
protocol PresenterToViewMusicDetailProtocol: AnyObject {
    func displaySongDetail(song: SongModel)
    func displaySongImage(image: UIImage?)
}

// MARK: View Output
protocol ViewToPresenterMusicDetailProtocol: AnyObject {
    var view: PresenterToViewMusicDetailProtocol? { get set }
    var interactor: PresenterToInteractorMusicDetailProtocol? { get set }
    var router: PresenterToRouterMusicDetailProtocol? { get set }
    var song: SongModel? { get set }
    
    func viewDidLoad()
    func loadSongImage(from url: URL)
}

// MARK: Interactor Input
protocol PresenterToInteractorMusicDetailProtocol: AnyObject {
    var presenter: InteractorToPresenterMusicDetailProtocol? { get set }
    var song: SongModel? { get set }
    
    func fetchSongDetail()
    func fetchSongImage(from url: URL)
}


// MARK: Interactor Output
protocol InteractorToPresenterMusicDetailProtocol: AnyObject {
    func fetchedSongDetail(song: SongModel)
    func fetchedSongImage(image: UIImage?)
}



