//
//  BackgroundAsyncImage.swift
//  proyecto-x
//
//  Created by Francisco Zapiola on 09/12/2021.
//

import SwiftUI

struct BackgroundFallback : View {
    var body: some View{
        Color(red: 111/255, green: 156/255, blue: 235/255)
            .ignoresSafeArea()
    }
}

struct BackgroundAsyncImage: View {
    let screenGeometry : GeometryProxy
    var body: some View {
        if #available(iOS 15.0, *) {
            AsyncImage(
                url: URL(string: "https://images.unsplash.com/photo-1555679427-1f6dfcce943b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODAxNzN8MHwxfGFsbHx8fHx8fHx8fDE2Mzg5MDk1MjM&ixlib=rb-1.2.1&q=80&w=1080"),
               content: {
                   image in
                        image
                        .resizable()
                        .fixedSize(horizontal: true, vertical: true)
                        .frame(width: screenGeometry.size.width, height: screenGeometry.size.height)
                        .ignoresSafeArea()
               },
               placeholder: {
                   BackgroundFallback()
               })
        } else {
            // Fallback on earlier versions
            BackgroundFallback()
        }
        
    }
}
