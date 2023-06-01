//
//  MusicRouter.swift
//  Arcane
//
//  Created by Владимир on 30.05.23.
//

import UIKit

class MusicRouter: PresenterToRouterMusicProtocol {
    
    static func createModule() -> UINavigationController {
        let view = MusicViewController()
        
        var presenter: ViewToPresenterMusicProtocol & InteractorToPresenterMusicProtocol = MusicPresenter()
        var interactor: PresenterToInteractorMusicProtocol = MusicInteractor()
        let router: PresenterToRouterMusicProtocol = MusicRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        let navigationController = UINavigationController(rootViewController: view)
        return navigationController
    }
    
    func pushToPlayerScreen(navigationController: UINavigationController, song: SongModel) {
        let musicDetailViewController = MusicDetailRouter.createMusicDetailModule(with: song)
        navigationController.pushViewController(musicDetailViewController, animated: true)
    }
}
