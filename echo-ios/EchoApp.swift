//
//  EchoApp.swift
//  echo-ios
//
//  Created by Tomohiko Ikeda on 2022/12/05.
//

import SwiftUI

@main
struct EchoApp: App {
    @AppStorage("isDarkMode") var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            Menu()
                .environmentObject(ToastContext())
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
