//
//  DataParser.swift
//  APICaller
//
//  Created by Zain Wu on 2024/5/29.
//

import Foundation

final class DataParser {
    static func parseData<T: Decodable>(_ data: Data) -> Result<T, Error> {
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            let error = NSError(domain: "Data Parsing Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not parse Data"])
            return .failure(error)
        }
        return .success(decodedData)
    }
}
