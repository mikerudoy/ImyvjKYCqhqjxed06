//
//  ContentView.swift
//  SwiftUIMarathon06
//
//  Created by Mike Rudoy on 14/05/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var isHorizontal = true
    private let squaresCount = 7
    @State var safeVerticalAreaLength: CGFloat = 0
    var body: some View {
        let layout = isHorizontal ? AnyLayout(HStackLayout(alignment: .center, spacing: 10)) :
        AnyLayout(VStackLayout(alignment: .leading, spacing: 0))
        GeometryReader { geometry in
            layout {
                ForEach(0..<squaresCount, id: \.self) { index in
                    rectangle()
                        .alignmentGuide(HorizontalAlignment.leading) { _ in
                            let squareSize = (geometry.frame(in: .global).height) / CGFloat(squaresCount)
                            let offset = (UIScreen.main.bounds.width - squareSize) / (CGFloat(squaresCount - 1))
                            let v = CGFloat(index) * offset
                            return v
                        }
                }
            }
            .frame(
                width: geometry.frame(in: .global).width,
                height: geometry.frame(in: .local).height
            )
            .environment(\.layoutDirection, isHorizontal ? .rightToLeft : .leftToRight)
        }.safeAreaPadding(.bottom, 10)
    }
    
    func rectangle() -> some View {
        ZStack {
            Rectangle()
                .fill(Color.blue)
                .aspectRatio(1.0, contentMode: .fit)
                .cornerRadius(10)
                .gesture(TapGesture().onEnded({ _ in
                    withAnimation {
                        self.isHorizontal.toggle()
                    }
                }))
        }
    }
}



#Preview {
    ContentView()
}
