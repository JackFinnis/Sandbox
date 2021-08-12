//
//  Actors.swift
//  Actors
//
//  Created by William Finnis on 03/08/2021.
//

import SwiftUI

actor Person {
    var score = 10
    
    func printScore() {
        print(score)
    }
    
    func copyScore(from other: Person) async {
        // Need to await writing to a property
        await score = other.score
        
        // Don't need to wait to read a property
        print(score)
    }
}

actor Team {
    var players: Set<Player>
    
    init(initialPlayers: Set<Player>) {
        self.players = initialPlayers
    }
    
    func transfer(player: Player, to otherTeam: Team) async {
        guard players.contains(player) else { return }
        await otherTeam.receive(player)
    }
    
    func receive(_ player: Player) {
        players.insert(player)
    }
    
    // Using 'isolated' passes the function to be completed by the other actor ('otherTeam' in this case)
    func printTeam(otherTeam: isolated Team) {
        print(otherTeam.players)
    }
}

actor Player: Hashable {
    let id: Int
    var name: String
    var salary: Decimal
    
    init(id: Int, name: String, salary: Decimal) {
        self.id = id
        self.name = name
        self.salary = salary
    }
    
    // Only using an actor's constant
    // Can call outside the object
    nonisolated func printID() {
        print(id)
    }
    
    func offerRaise(amount: Decimal) {
        guard amount > 0 else {
            print("That's it, I quit!")
            return
        }
        
        salary += amount
    }
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        lhs.id == rhs.id
    }
    
    nonisolated var hashValue: Int { id }
    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

actor URLCache {
    var cache = [URL: Data]()
    
    func data(for url: URL) async throws -> Data {
        if let cached = cache[url] {
            return cached
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        cache[url] = data
        return data
    }
}

struct Actors: View {
    var body: some View {
        Text("Hello, World!")
    }
}
