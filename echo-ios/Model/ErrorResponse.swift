//
//  ErrorResponse.swift
//  echo-ios
//
//  Created by Tomohiko Ikeda on 2022/12/14.
//

import Foundation

struct ErrorResponse: Codable {
    struct Error: Codable {
        let message: String
        let field: String?
        init(message: String, field: String?) {
            self.message = message
            self.field = field
        }
    }
    let errors: [Error]
    init(errors: [Error]) {
        self.errors = errors
    }
}
