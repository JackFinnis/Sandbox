//
//  Extensions.swift
//  Extensions
//
//  Created by William Finnis on 03/08/2021.
//

import Foundation

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async throws {
        let duration = UInt64(seconds * 1_000_000_000)
        try await sleep(nanoseconds: duration)
    }
}

extension URLSession {
    func decode<T: Decodable>(_ type: T.Type = T.self, from url: URL) async throws -> T {
        let (data, _) = try await data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
