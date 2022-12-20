//
//  Menu.swift
//  echo-ios
//
//  Created by Tomohiko Ikeda on 2022/12/20.
//

import SwiftUI

struct Menu: View {
    @AppStorage("isDarkMode") var isDarkMode = false
    @EnvironmentObject private var toast: ToastContext

    private func toggleAppearance() {
        isDarkMode.toggle()
        if isDarkMode {
            toast.push([Notification(message: "Appearance updated: Dark", style: .success)])
        } else {
            toast.push([Notification(message: "Appearance updated: Light", style: .info)])
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink(destination: Messages()) {
                    Text("Messages")
                }
            } //: List
            .navigationTitle("Echo")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        toggleAppearance()
                    } label: {
                        Image(systemName: isDarkMode ? "moon.circle.fill" : "moon.circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .font(.system(.title, design: .rounded))
                    }
                }
            }
        } //: NavigationStack
        .onToast()
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
