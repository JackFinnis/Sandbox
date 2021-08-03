//
//  AsyncAwait.swift
//  AsyncAwait
//
//  Created by William Finnis on 02/08/2021.
//

import SwiftUI

struct AsyncAwait: View {
    @State var inbox = [Message]()
    @State var sent = [Message]()
    
    @State var selectedMailbox = "Inbox"
    let messageBoxes = ["Inbox", "Sent"]
    
    var messages: [Message] {
        if selectedMailbox == "Inbox" {
            return inbox
        } else {
            return sent
        }
    }
    
    var body: some View {
        NavigationView {
            List(messages) { message in
                VStack(alignment: .leading) {
                    Text(message.user)
                        .font(.headline)
                    Text(message.text)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
            }
            .navigationTitle(selectedMailbox)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Picker("Select a mailbox", selection: $selectedMailbox) {
                        ForEach(messageBoxes, id: \.self) { mailbox in
                            Text(mailbox)
                        }
                    }
                    .pickerStyle(.segmented)
                }
            }
            .task {
                // Able to start async code from a sync function
                Task {
                    let inboxURL = URL(string: "https://hws.dev/inbox.json")!
                    inbox = try await URLSession.shared.decode(from: inboxURL)
                }
                Task {
                    let sentURL = URL(string: "https://hws.dev/sent.json")!
                    sent = try await URLSession.shared.decode(from: sentURL)
                }
            }
        }
    }
}
