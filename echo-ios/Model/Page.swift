//
//  Page.swift
//  echo-ios
//
//  Created by Tomohiko Ikeda on 2022/12/13.
//

import Foundation

struct Page: Codable {
    let hasNextPage: Bool
    let cursor: String?
    init(hasNextPage: Bool, cursor: String?) {
        self.hasNextPage = hasNextPage
        self.cursor = cursor
    }
}
