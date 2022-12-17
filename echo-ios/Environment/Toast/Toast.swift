//
//  Toast.swift
//  echo-ios
//
//  Created by Tomohiko Ikeda on 2022/12/14.
//

import SwiftUI

/**
    How to install the Toast
    1. you should install ToastContext's instance to a root view as an environment object.
    2. then set onToast modifier to a view on which you want to show toast banners.
 */
class ToastContext: ObservableObject {
    @Published fileprivate var queue: [Notification] = []
    
    @MainActor
    func push(_ notifications: [Notification]) {
        queue.append(contentsOf: notifications)
    }
}

struct ToastProviderViewModifier: ViewModifier {
    @EnvironmentObject private var context: ToastContext
    @State private var notifications: [Notification] = []
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            VStack {
                ForEach(notifications) { notification in
                    Banner(notification: notification) {
                        withAnimation {
                            notifications = notifications.filter { $0.id != notification.id }
                        }
                    }
                    .zIndex(1)
                    .transition(.move(edge: .trailing))
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 8))
        }
        .onChange(of: context.queue) { newValue in
            guard !newValue.isEmpty else {
                return
            }
            withAnimation {
                notifications.append(contentsOf: newValue)
            }
            context.queue = []
        }
    }
}

extension View {
    func onToast() -> some View {
        modifier(ToastProviderViewModifier())
    }
}
