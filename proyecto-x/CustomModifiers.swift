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
            .foregroundColor(.white)
    }
}

struct CustomCell: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 120, height: 120)
            .foregroundColor(Color(red: 20/255, green: 27/255, blue: 65/255))
    }
}

struct CustomCellContainer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 400, height: 400)
            .padding()
            .background(Color(red: 152/255, green: 185/255, blue: 242/255))
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
    func customCellStyle() -> some View {
        modifier(CustomCell())
    }
    func customCellContainerStyle() -> some View {
        modifier(CustomCellContainer())
    }
    func customButtonStyle() -> some View {
        modifier(CustomButton())
    }
}
