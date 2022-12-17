//
//  MessageCell.swift
//  echo-ios
//
//  Created by Tomohiko Ikeda on 2022/12/13.
//

import SwiftUI
import EchoToolbox

struct MessageCell: View {
    let message: Message
    let formatter = RelativeDateTimeFormatter()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 8) {
                AsyncImage(url: message.by.thumbnail) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 32, height: 32)
                .clipShape(Circle())
                .overlay(Circle().stroke(.purple, lineWidth: 1))
                Text(message.by.name)
                    .font(.footnote)
                    .fontWeight(.heavy)
                Text(message.created, format: Date.RelativeFormatStyle.relative(presentation: .numeric))
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
            }  //: HStack
            VStack(alignment: .leading, spacing: 12) {
                Text(message.text)
                    .font(.body)
                    .fontWeight(.regular)
                    
                Divider()
            } //: VStack
            .padding(.leading, 40)
            .padding(.trailing, 12)
        }  //: VStack
    }
}

struct MessageCell_Previews: PreviewProvider {
    static var previews: some View {
        MessageCell(message: Toolbox.shared.preview(Message.self, scene: "preview", case: "message"))
            .previewLayout(.sizeThatFits)
    }
}
