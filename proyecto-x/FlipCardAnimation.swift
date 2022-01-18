//
//  flipCardAnimation.swift
//  proyecto-x
//
//  Created by Lisbaldy de Jesus on 15/01/2022.
//

import SwiftUI

struct FlipCardAnimation: View {
    @State var flipped = false
    
    var body: some View {
        
        let flipDegrees = flipped ? -180.0 : 0
        
        return VStack{
            Spacer()
            
            ZStack() {
                Text("FRONT").placedOnCard(Color.blue).flipRotate(flipDegrees).opacity(flipped ? 0.0 : 1.0)
                Text("BACK").placedOnCard(Color.green).flipRotate(-180 + flipDegrees).opacity(flipped ? 1.0 : 0.0)
            }
            .animation(.easeInOut(duration: 0.6))
            .onTapGesture { self.flipped.toggle() }
            Spacer()
        }
    }
}

extension View {
    
    func flipRotate(_ degrees : Double) -> some View {
        return rotation3DEffect(Angle(degrees: degrees), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    func placedOnCard(_ color: Color) -> some View {
        return padding(5).frame(width: 70, height: 120, alignment: .center).background(color).foregroundColor(Color.white)
    }
}

//struct FlipCardAnimation: View {
//
//      @State private var flipped = false
//      @State private var animate3d = false
//
//      var body: some View {
//
//            return VStack {
//                  Spacer()
//
//                  ZStack() {
//                        FrontCard().opacity(flipped ? 0.0 : 1.0)
//                        BackCard().opacity(flipped ? 1.0 : 0.0)
//                  }
//                  .modifier(FlipEffect(flipped: $flipped, angle: animate3d ? 180 : 0, axis: (x: 0, y: 1)))
//                  .onTapGesture {
//                        withAnimation(Animation.linear(duration: 0.8)) {
//                              self.animate3d.toggle()
//                        }
//                  }
//                  Spacer()
//            }
//      }
//}
//
//struct FlipEffect: GeometryEffect {
//
//      var animatableData: Double {
//            get { angle }
//            set { angle = newValue }
//      }
//
//      @Binding var flipped: Bool
//      var angle: Double
//      let axis: (x: CGFloat, y: CGFloat)
//
//      func effectValue(size: CGSize) -> ProjectionTransform {
//
//            DispatchQueue.main.async {
//                  self.flipped = self.angle >= 90 && self.angle < 270
//            }
//
//            let tweakedAngle = flipped ? -180 + angle : angle
//            let a = CGFloat(Angle(degrees: tweakedAngle).radians)
//
//            var transform3d = CATransform3DIdentity;
//            transform3d.m34 = -1/max(size.width, size.height)
//
//            transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
//            transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
//
//            let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
//
//            return ProjectionTransform(transform3d).concatenating(affineTransform)
//      }
//}
//
//struct FrontCard : View {
//      var body: some View {
//            Text("FRONT").padding(5).frame(width: 70, height: 120, alignment: .center).background(Color.yellow)
//      }
//}
//
//struct BackCard : View {
//      var body: some View {
//            Text("BACK").padding(5).frame(width: 70, height: 120).background(Color.green)
//      }
//}
