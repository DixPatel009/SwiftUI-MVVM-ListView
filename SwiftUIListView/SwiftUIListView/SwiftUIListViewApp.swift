//
//  SwiftUIListViewApp.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import SwiftUI

@main
struct SwiftUIListViewApp: App {

    //MARK:- PROPERTIES
    @AppStorage("isDarkMode") private var isDarkMode = false // Set Application Appearance Mode

    //MARK:- BODY
    var body: some Scene {
        WindowGroup {
            SplashScreen().preferredColorScheme(isDarkMode ? .dark : .light)
                .environment(\.locale, .init(identifier: "en"))
        }
    }
}
