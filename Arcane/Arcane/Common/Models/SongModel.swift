//
//  SongModel.swift
//  Arcane
//
//  Created by Владимир on 30.05.23.
//

import Foundation

struct SongModel: Codable, Equatable {
    let trackId: Int?
    let trackName: String?
    let artistName: String?
    let artworkUrl100: String?
}
