//
//  MainActors.swift
//  MainActors
//
//  Created by William Finnis on 03/08/2021.
//

import Foundation
import SwiftUI

@MainActor
class ViewModel: ObservableObject {
    @Published var age: Int = 0
}

struct MainActors: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        Text("Hello, world!")
    }
}
