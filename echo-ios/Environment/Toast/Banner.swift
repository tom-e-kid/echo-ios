//
//  Banner.swift
//  echo-ios
//
//  Created by Tomohiko Ikeda on 2022/12/16.
//

import SwiftUI

extension Notification.Style {
    var image: Image {
        switch self {
        case .success:
            return Image(systemName: "checkmark.circle")
        case .error:
            return Image(systemName: "exclamationmark.octagon")
        case .warning:
            return Image(systemName: "exclamationmark.triangle")
        case .info:
            return Image(systemName: "info.circle")
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .success:
            return .green
        case .error:
            return .red
        case .warning:
            return .yellow
        case .info:
            return .cyan
        }
    }
}

struct Banner: View {
    let notification: Notification
    var onClose: (() -> Void)?

    @State private var timer: Timer?

    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 8) {
            notification.style.image
            Text(notification.message)
            Spacer()
            if notification.closable {
                Button(action: {
                    timer?.invalidate(); timer = nil
                    onClose?()
                }) {
                    Image(systemName: "xmark")
                }
            }
        }
        .font(.subheadline)
        .fontWeight(.regular)
        .foregroundColor(.white)
        .padding(.horizontal, 8)
        .padding(.vertical, 8)
        .background(RoundedRectangle(cornerRadius: 4)
            .foregroundColor(notification.style.backgroundColor)
            .shadow(color: Color(white: 0, opacity: 0.2), radius: 2)
        )
        .task {
            timer = Timer.scheduledTimer(withTimeInterval: notification.duration, repeats: false) { (t) in
                onClose?()
                timer = nil
            }
        }
    }
}

struct Banner_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Banner(notification: Notification(message: "Hello Banner :)", style: .info))
            Banner(notification: Notification(message: "Hello Banner :)", style: .error))
            Banner(notification: Notification(message: "Hello Banner :)", style: .success))
            Banner(notification: Notification(message: "Hello Banner :)", style: .warning))

            Banner(notification: Notification(message: "Hello Banner :)", closable: false, style: .info))
            Banner(notification: Notification(message: "This is a long message. This is a long message. This is a long message. This is a long message.", style: .error))
        }
        .previewLayout(.sizeThatFits)
    }
}
