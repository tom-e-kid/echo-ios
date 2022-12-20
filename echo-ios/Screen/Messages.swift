//
//  Messages.swift
//  echo-ios
//
//  Created by Tomohiko Ikeda on 2022/12/05.
//

import SwiftUI
import EchoToolbox

extension Message: Identifiable {}

extension ErrorResponse: LocalizedError {
    var errorDescription: String? {
        errors.map { $0.field != nil ? "\($0.field!): \($0.message)" : "\($0.message)" }.joined(separator: ", ")
    }
}

class ViewState: ObservableObject {
    enum Error: Swift.Error {
        case response(String?)
    }
    
    @Published var messages: [Message] = []
    @Published var pageInfo: Page?
    
    @MainActor
    func refresh() async throws {
        let result = try await Toolbox.shared.echo(
            MessagesResponse.self,
            ErrorResponse.self,
            scene: "messages",
            case: "first-page"
        )
        switch result {
        case .success(let res):
            messages = res.messages
            pageInfo = res.page
        case .failure(let res):
            throw res
        }
    }
    
    @MainActor
    func page() async throws {
        let result = try await Toolbox.shared.echo(
            MessagesResponse.self,
            ErrorResponse.self,
            scene: "messages",
            case: "last-page"
        )
        switch result {
        case .success(let res):
            messages += res.messages
            pageInfo = res.page
        case .failure(let res):
            throw res
        }
    }
}

struct Messages: View {
    
    @StateObject private var state = ViewState()
    @EnvironmentObject private var toast: ToastContext
    
    private func refresh() async {
        do {
            try await state.refresh()
        } catch {
            toast.push([Notification(message: error.localizedDescription, style: .error)])
        }
    }
    
    private func page() async {
        do {
            try await state.page()
        } catch {
            toast.push([Notification(message: error.localizedDescription, style: .error)])
        }
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(state.messages) { messages in
                        MessageCell(message: messages)
                    }
                    if let pageInfo = state.pageInfo, pageInfo.hasNextPage {
                        HStack(spacing: 8) {
                            Spacer()
                            ProgressView()
                            Text("Loading...")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundColor(.accentColor)
                            Spacer()
                        }  //: HStack
                        .padding()
                        .onAppear {
                            Task {
                                await page()
                            }
                        }
                    }
                }  //: LazyVStack
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 8))
            }  //: ScrollView
            .task {
                await refresh()
            }
            .refreshable {
                await refresh()
            }
        } //: ZStack
        .navigationTitle("Messages")
    }
}

struct Messages_Previews: PreviewProvider {
    static var previews: some View {
        Messages()
            .environmentObject(ToastContext())
    }
}
