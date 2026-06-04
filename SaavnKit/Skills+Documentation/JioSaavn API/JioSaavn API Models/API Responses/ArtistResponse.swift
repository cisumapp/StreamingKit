//
//  ArtistResponse.swift
//  cisum
//
//  Created by Aarav Gupta on 29/05/24.
//

import Foundation

struct JioSaavnArtistResponse: Codable {
    let data: JioSaavnArtistData

    struct JioSaavnArtistData: Codable {
        let total: Int
        let start: Int
        let results: [JioSaavnArtistResult]

        struct JioSaavnArtistResult: Codable {
            let id, name: String
            let url: String
            let followerCount: Int
            let fanCount: String
            let role: String
            let image: [DownloadUrl]
            let topSongs: [Single]
            let topAlbums: [TopAlbum]
            let singles: [Single]
            let similarArtists: [SimilarArtistData]

            struct Single: Codable {
                let id, name: String
                let year: String
                let duration: Int?
                let explicitContent: Bool
                let hasLyrics: Bool
                let url: String
                let album: JioSaavnAlbum
                let artists: JioSaavnArtist
                let image, downloadUrl: [DownloadUrl]
            }

            struct SimilarArtistData: Codable {
                let id, name: String
                let url: String
                let image: [DownloadUrl]
                let role: String
                let aka: String
                let similarArtists: [SimilarArtist]

                struct SimilarArtist: Codable {
                    let name, id: String
                }
            }

            struct TopAlbum: Codable {
                let id, name: String
                let year: Int
                let explicitContent: Bool
                let url: String
                let songCount: Int
                let artists: JioSaavnArtist
                let image: [DownloadUrl]
            }
        }
    }
}
