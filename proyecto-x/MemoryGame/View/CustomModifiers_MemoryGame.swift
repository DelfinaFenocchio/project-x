//
//  CustomModifiersMemory.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 20/01/2022.
//

import SwiftUI

struct CustomCellMG: ViewModifier {
    let width : CGFloat
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: width)
            .foregroundColor(Color(red: 20/255, green: 27/255, blue: 65/255))
    }
}

struct CustomCellFlippedMG: ViewModifier {
    let width : CGFloat
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: width)
            .foregroundColor(Color(red: 200/255, green: 17/255, blue: 125/255))
    }
}


extension View {
    func customCellStyleMG(width: CGFloat) -> some View {
        modifier(CustomCellMG(width: width))
    }
    func customCellFlippedStyleMG(width: CGFloat) -> some View {
        modifier(CustomCellFlippedMG(width: width))
    }
}
