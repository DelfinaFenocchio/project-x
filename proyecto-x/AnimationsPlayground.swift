//
//  AnimationsPlayground.swift
//  proyecto-x
//
//  Created by Lisbaldy de Jesus on 11/01/2022.
//

import SwiftUI

struct AnimationsPlayground: View {
    @State private var meeting = true
    
    var textToDisplay : [String] = ["Hello mi doña!", "Chao caballero!"]
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Spacer()
                Spacer()
                
                Text(textToDisplay[meeting ? 0 : 1])
                    .font(.system(size: 20))
                
                Spacer()
                
                Button {
                    meeting.toggle()
                } label: {
                    Label("", systemImage: "folder.badge.plus")
                        .rotationEffect(Angle.degrees(meeting ? 0 : 360))
                        .animation(.easeOut(duration: 0.3), value: meeting)
                        .scaleEffect(meeting ? 2 : 3)
                        .animation(.easeInOut(duration: 0.5), value: meeting)
                }
                
                Spacer()
                
                NavigationLink(destination: FlipCardAnimation()) {
                    Text("Navigate to flip card animation")
                        .customButtonStyle()
                }
                
                Spacer()
            }
        }
    }
}

//struct AnimationsPlayground_Previews: PreviewProvider {
//    static var previews: some View {
//        AnimationsPlayground()
//    }
//}
