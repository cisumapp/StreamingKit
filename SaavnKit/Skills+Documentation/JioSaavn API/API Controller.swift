//
//  API Controller.swift
//  cisum
//
//  Created by Aarav Gupta on 24/05/24.
//

import Foundation

final class APIController {
    static let shared = APIController()

    private static let baseUrl: String = "https://saavn.dev"

    func searchSongs(
        query: String,
        page: Int,
        limit: Int,
        completion: @escaping (_ result: Result<JioSaavnSongResponse, Error>) -> Void
    ) {
        let url = Self.baseUrl + "/api/search/songs"
        let queryItems: [String: Any] = ["query": query, "page": page, "limit": limit]

        NetworkManager.requestGet(
            url: url,
            queryItems: queryItems,
            headers: nil
        ) { result in
            switch result {
            case let .success(data): ()
                let parseResult: Result<JioSaavnSongResponse, Error> = DataParser.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func searchAlbums(
        query: String,
        page: Int,
        limit: Int,
        completion: @escaping (_ result: Result<JioSaavnAlbumResponse, Error>) -> Void
    ) {
        let url = Self.baseUrl + "/api/search/albums"
        let queryItems: [String: Any] = ["query": query, "page": page, "limit": limit]

        NetworkManager.requestGet(
            url: url,
            queryItems: queryItems,
            headers: nil
        ) { result in
            switch result {
            case let .success(data): ()
                let parseResult: Result<JioSaavnAlbumResponse, Error> = DataParser.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func searchArtists(
        query: String,
        page: Int,
        limit: Int,
        completion: @escaping (_ result: Result<JioSaavnArtistResponse, Error>) -> Void
    ) {
        let url = Self.baseUrl + "/api/search/artists"
        let queryItems: [String: Any] = ["query": query, "page": page, "limit": limit]

        NetworkManager.requestGet(
            url: url,
            queryItems: queryItems,
            headers: nil
        ) { result in
            switch result {
            case let .success(data): ()
                let parseResult: Result<JioSaavnArtistResponse, Error> = DataParser.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func searchPlaylists(
        query: String,
        page: Int,
        limit: Int,
        completion: @escaping (_ result: Result<JioSaavnPlaylistResponse, Error>) -> Void
    ) {
        let url = Self.baseUrl + "/api/search/playlists"
        let queryItems: [String: Any] = ["query": query, "page": page, "limit": limit]

        NetworkManager.requestGet(
            url: url,
            queryItems: queryItems,
            headers: nil
        ) { result in
            switch result {
            case let .success(data): ()
                let parseResult: Result<JioSaavnPlaylistResponse, Error> = DataParser.parseData(data)
                completion(parseResult)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
