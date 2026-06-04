//
//  PlaylistResponse.swift
//  cisum
//
//  Created by Aarav Gupta on 29/05/24.
//

import Foundation

struct JioSaavnPlaylistResponse: Codable {
    let data: JioSaavnPlaylistData

    struct JioSaavnPlaylistData: Codable {
        let total: Int
        let start: Int
        let results: [JioSaavnPlaylistResult]

        struct JioSaavnPlaylistResult: Codable {
            let id, name, type: String
            let explicitContent: Bool
            let url: String
            let songCount: Int
            let artists: JioSaavnArtist
            let image: [DownloadUrl]
            let songs: [JioSaavnSongResult]

            struct JioSaavnSongResult: Codable {
                let id: String
                let name: String
                let type: String
                let year: String
                let duration: Int
                let explicitContent: Bool
                let hasLyrics: Bool
                let url: String
                let album: JioSaavnAlbum
                let artists: JioSaavnArtist
                let image: [DownloadUrl]
                let downloadUrl: [DownloadUrl]
            }
        }
    }
}
