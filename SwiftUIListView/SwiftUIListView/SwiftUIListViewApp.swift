//
//  SwiftUIListViewApp.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import SwiftUI

@main
struct SwiftUIListViewApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
