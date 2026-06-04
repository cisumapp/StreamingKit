//
//  Common Models.swift
//  cisum
//
//  Created by Aarav Gupta on 25/05/24.
//

import Foundation

// MARK: - DownloadURL

struct DownloadUrl: Codable {
    let quality: Quality
    let url: String

    enum Quality: String, Codable {
        case audio12Kbps = "12kbps"
        case audio48Kbps = "48kbps"
        case audio96Kbps = "96kbps"
        case audio160Kbps = "160kbps"
        case audio320Kbps = "320kbps"
        case img50X50 = "50x50"
        case img150X150 = "150x150"
        case img500X500 = "500x500"
    }
}

// MARK: - Album

struct JioSaavnAlbum: Codable {
    let id: String
    let name: String
    let url: String
}

// MARK: - Artists

struct JioSaavnArtist: Codable {
    let primary, featured, all: [SimplifiedArtist]
}

// MARK: - All

struct SimplifiedArtist: Codable {
    let id: String
    let name: String
    let role: String
    let image: [DownloadUrl]
    let type: String
    let url: String
}

// enum Role: String, Codable {
//    case featuredArtists = "featured_artists"
//    case lyricist = "lyricist"
//    case music = "music"
//    case primaryArtists = "primary_artists"
//    case singer = "singer"
//    case empty = ""
//    case singers = "singers"
// }
