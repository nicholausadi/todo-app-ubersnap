//
//  TodoListUbersnapApp.swift
//  TodoListUbersnap
//
//  Created by Nicholaus Adisetyo Purnomo on 01/08/23.
//

import SwiftUI

@main
struct TodoListUbersnapApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            TodoHomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
