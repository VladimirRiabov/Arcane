//
//  MusicViewController.swift
//  Arcane
//
//  Created by Владимир on 30.05.23.
//

import UIKit

class MusicViewController: UIViewController {
    
    private let cellID = "cell"
    var presenter: ViewToPresenterMusicProtocol?
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    private let progressView = UIActivityIndicatorView(style: .large)
    
    private var songs: [SongModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    private func setupView() {
        tableView.register(SongCell.self, forCellReuseIdentifier: cellID)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Songs"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        
        progressView.center = view.center
        view.addSubview(progressView)
    }
}

extension MusicViewController: PresenterToViewMusicProtocol {
    
    func onFetchSongs(songs: [SongModel]) {
        DispatchQueue.main.async {
            self.songs = songs
            self.tableView.reloadData()
        }
    }
    
    func displaySongImage(image: UIImage?, forSong: SongModel) {
        guard let index = songs.firstIndex(where: { $0 == forSong }) else { return }
        if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? SongCell {
            cell.songImageView.image = image
        }
    }
    
    func showProgressView() {
        progressView.startAnimating()
    }
    
    func hideProgressView() {
        progressView.stopAnimating()
    }
}


extension MusicViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SongCell
        let song = songs[indexPath.row]
        cell.configureCell(song: song)
        presenter?.fetchImageForSong(song: song)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.selectSongAt(indexPath: indexPath)
    }
}

extension MusicViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let keyword = searchController.searchBar.text else { return }
        presenter?.searchSongWith(keyword: keyword)
    }
}

