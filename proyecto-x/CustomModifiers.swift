//
//  customModifiers.swift
//  proyecto-x
//
//  Created by Rodolfo.Iribarren on 26/10/2021.
//
import SwiftUI

struct CustomButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct CustomText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(red: 20/255, green: 27/255, blue: 65/255))
    }
}

struct CustomCell: ViewModifier {
    let width : CGFloat
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: width)
            .foregroundColor(Color(red: 20/255, green: 27/255, blue: 65/255))
    }
}

struct CustomCellContainer: ViewModifier {
    let width : CGFloat
    func body(content: Content) -> some View {
        content
            .frame(width: width, height: 400)
            .background(Color(red: 152/255, green: 185/255, blue: 242/255, opacity: 0.7))
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.red)
            .padding()
    }
}

extension View {
    func customTextStyle() -> some View {
        modifier(CustomText())
    }
    func customCellStyle(width: CGFloat) -> some View {
        modifier(CustomCell(width: width))
    }
    func customCellContainerStyle(width: CGFloat) -> some View {
        modifier(CustomCellContainer(width: width))
    }
    func customButtonStyle() -> some View {
        modifier(CustomButton())
    }
}
