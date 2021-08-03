//
//  Models.swift
//  Models
//
//  Created by William Finnis on 03/08/2021.
//

import Foundation

struct Message: Codable, Identifiable {
    let id: Int
    let user: String
    let text: String
}

struct User: Identifiable {
    let id = UUID()
    var name: String
    var isContacted = false
}
