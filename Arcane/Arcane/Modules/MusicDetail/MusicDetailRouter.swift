//
//  MusicDetailRouter.swift
//  Arcane
//
//  Created by Владимир on 31.05.23.
//

import Foundation

class MusicDetailRouter: PresenterToRouterMusicDetailProtocol {
    
    static func createMusicDetailModule(with song: SongModel) -> MusicDetailViewController {
        let view = MusicDetailViewController()
        
        let presenter: ViewToPresenterMusicDetailProtocol & InteractorToPresenterMusicDetailProtocol = MusicDetailPresenter()
        let interactor: PresenterToInteractorMusicDetailProtocol = MusicDetailInteractor()
        let router: PresenterToRouterMusicDetailProtocol = MusicDetailRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        presenter.song = song
        
        return view
    }
}
