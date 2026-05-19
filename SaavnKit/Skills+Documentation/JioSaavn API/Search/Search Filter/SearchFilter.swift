//
//  SearchFilter.swift
//  cisum
//
//  Created by Aarav Gupta on 30/05/24.
//

import Foundation

struct SearchFilterModel: Identifiable {
    private(set) var id: SearchFilter
    var size: CGSize = .zero
    var minX: CGFloat = .zero
    
    enum SearchFilter: String, CaseIterable {
        case songs = "Songs"
        case artists = "Artists"
        case albums = "Albums"
        case playlists = "Playlists"
        case users = "Users"
    }
}
