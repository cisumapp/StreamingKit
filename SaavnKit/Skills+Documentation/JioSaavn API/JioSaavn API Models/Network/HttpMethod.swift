//
//  HttpMethod.swift
//  APICaller
//
//  Created by Zain Wu on 2024/5/29.
//

import Foundation

enum HttpMethod {
    case get
    case post

    var rawString: String {
        switch self {
        case .get:
            "GET"
        case .post:
            "POST"
        }
    }
}
