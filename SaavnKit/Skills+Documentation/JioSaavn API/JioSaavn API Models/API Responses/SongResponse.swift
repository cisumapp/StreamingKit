//
//  SongResponse.swift
//  cisum
//
//  Created by Aarav Gupta on 29/05/24.
//

import Foundation

struct JioSaavnSongResponse: Codable {
    let data: JioSaavnSongData
    
    struct JioSaavnSongData: Codable {
        let total: Int
        let start: Int
        let results: [JioSaavnSongResult]
        
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
