//
//  MusicDetailViewController.swift
//  Arcane
//
//  Created by Владимир on 30.05.23.
//

import UIKit

class MusicDetailViewController: UIViewController, PresenterToViewMusicDetailProtocol {
    var presenter: ViewToPresenterMusicDetailProtocol?
    
    let songImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let songTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    let artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    let playStopButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play/Stop", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    
    func setupView() {
        view.addSubview(songImage)
        view.addSubview(songTitleLabel)
        view.addSubview(artistNameLabel)
        view.addSubview(playStopButton)
        
        NSLayoutConstraint.activate([
            songImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            songImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            songImage.widthAnchor.constraint(equalToConstant: 200),
            songImage.heightAnchor.constraint(equalToConstant: 200),
            
            songTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            songTitleLabel.topAnchor.constraint(equalTo: songImage.bottomAnchor, constant: 20),
            
            artistNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            artistNameLabel.topAnchor.constraint(equalTo: songTitleLabel.bottomAnchor, constant: 10),
            
            playStopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playStopButton.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 20),
            playStopButton.widthAnchor.constraint(equalToConstant: 120),
            playStopButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func displaySongDetail(song: SongModel) {
        songTitleLabel.text = song.trackName
        artistNameLabel.text = song.artistName
        
        if let artworkUrlString = song.artworkUrl100, let artworkUrl = URL(string: artworkUrlString) {
            presenter?.loadSongImage(from: artworkUrl)
        }
    }
    
    func displaySongImage(image: UIImage?) {
        DispatchQueue.main.async { [weak self] in
            self?.songImage.image = image
        }
    }
}

