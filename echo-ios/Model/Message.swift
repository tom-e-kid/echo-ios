//
//  Message.swift
//  echo-ios
//
//  Created by Tomohiko Ikeda on 2022/12/13.
//

import Foundation

struct Message: Codable {
    let id: String
    let text: String
    let by: User
    let created: Date
    let updated: Date
    init(id: String, text: String, by: User, created: Date, updated: Date) {
        self.id = id
        self.text = text
        self.by = by
        self.created = created
        self.updated = updated
    }
}
