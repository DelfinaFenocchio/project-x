//
//  RetoScreen.swift
//  proyecto-x
//
//  Created by Lisbaldy Ojeda on 02/10/2021.
//

import SwiftUI

struct RetoScreen: View {
    var body: some View {
        VStack(alignment: .trailing) {
            Text("1").border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            Text("2").border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            Text("3").border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
            HStack(alignment: .top){
                Text("A").frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                Text("B").border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                Text("C").border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            }.background(Color.red)
            
        }.background(Color.blue)
    }
}

struct RetoScreen_Previews: PreviewProvider {
    static var previews: some View {
        Image("reto")
        RetoScreen()
    }
}
