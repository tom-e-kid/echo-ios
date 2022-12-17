//
//  User.swift
//  echo-ios
//
//  Created by Tomohiko Ikeda on 2022/12/13.
//

import Foundation

struct User: Codable {
    let id: String
    let email: String
    let name: String
    let thumbnail: URL
    init(id: String, email: String, name: String, thumbnail: URL) {
        self.id = id
        self.email = email
        self.name = name
        self.thumbnail = thumbnail
    }
}
