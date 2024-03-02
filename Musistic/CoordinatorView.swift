//
//  CoordinatorView.swift
//  Musistic
//
//  Created by Yuri Cunha on 29/02/24.
//

import SwiftUI

import SwiftUI

struct CoordinatorView: View {
    @State private var coordinator = Coordinator.shared

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.view(for: .login)
                .navigationDestination(for: NavigationType.self) { type in
                    coordinator.view(for: type)
                }
        }
        .environment(coordinator)
    }
}

#Preview {
    CoordinatorView()
}
