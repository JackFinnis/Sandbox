//
//  ContentView.swift
//  Sandbox
//
//  Created by William Finnis on 02/08/2021.
//

import SwiftUI

struct ContentView: View {
    @State var users = [
        User(name: "Taylor"),
        User(name: "Justin"),
        User(name: "Adele")
    ]
    
    var body: some View {
        List($users) { $user in
            HStack {
                Text(user.name)
                Spacer()
                Toggle("User has been contacted", isOn: $user.isContacted)
                    .labelsHidden()
            }
        }
        // Old way of doing it
        List {
            ForEach(0..<users.count, id: \.self) { i in
                HStack {
                    Text(users[i].name)
                    Spacer()
                    Toggle("User has been contacted", isOn: $users[i].isContacted)
                        .labelsHidden()
                }
            }
        }
        // End of old way
    }
}

// CGFloat === Double
func test1() {
    let first: CGFloat = 42
    let second: Double = 19
    let result = first + second
    print(result)
}

// Postfix member expression
func test2() {
    let name = ["Keeley", "Roy", "Ted"]
    let selected = name.randomElement()
    print(selected ?? "Anonymous")
}
