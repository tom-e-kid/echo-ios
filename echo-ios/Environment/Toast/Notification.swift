//
//  Notification.swift
//  echo-ios
//
//  Created by Tomohiko Ikeda on 2022/12/16.
//

import Foundation

struct Notification: Identifiable, Equatable {
    enum Style {
        case success, error, warning, info
    }
    let id = UUID()
    let message: String
    let duration: TimeInterval
    let closable: Bool
    let style: Style
    init(message: String, duration: TimeInterval = 3, closable: Bool = true, style: Style = .info) {
        self.message = message
        self.duration = duration
        self.closable = closable
        self.style = style
    }
}

