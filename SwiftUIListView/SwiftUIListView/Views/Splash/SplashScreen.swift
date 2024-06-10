//
//  SplashScreen.swift
//  SwiftUIListView
//
//  Created by Dixit Mac New on 10/06/24.
//

import SwiftUI

struct SplashScreen: View {
    @State var isActive:Bool = false
    
    var body: some View {
        if self.isActive {
            HomeScreen()
        } else {
            VStack(alignment: HorizontalAlignment.center, spacing: 20) {
                Image(uiImage: UIImage(named: "ic_splash_logo.png")!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 200)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .center
            )
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            })
        }
    }
}

#if DEBUG
struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
#endif
