//
//  MessagesResponse.swift
//  echo-ios
//
//  Created by Tomohiko Ikeda on 2022/12/12.
//

import Foundation

struct MessagesResponse: Codable {
    let messages: [Message]
    let page: Page
    init(messages: [Message], page: Page) {
        self.messages = messages
        self.page = page
    }
}
