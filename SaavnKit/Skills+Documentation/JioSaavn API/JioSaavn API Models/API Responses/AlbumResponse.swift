//
//  AlbumResponse.swift
//  cisum
//
//  Created by Aarav Gupta on 29/05/24.
//

import Foundation

struct JioSaavnAlbumResponse: Codable {
    let data: JioSaavnAlbumData
    
    struct JioSaavnAlbumData: Codable {
        let total: Int
        let start: Int
        let results: [JioSaavnAlbumResult]
        
        
        struct JioSaavnAlbumResult: Codable {
            let id, name, type: String
            let year: Int
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
