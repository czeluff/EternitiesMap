//
//  ContentView.swift
//  EternitiesMap
//
//  Created by Chad Zeluff on 10/3/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var scrollTarget: Int?
    // Work-around to firing a change in the scrollPosition. If the button were IN the ScrollViewReader context, I could do:
    // proxy.scrollTo(target, anchor: center)
    // as the button action.
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            GeometryReader { reader in
                // Wish I could put this scrollView into a local variable, but I can't because it utilizes GeometryReader
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { proxy in
                        HStack(spacing: 0) { // Could just as easily be a ZStack
                            Text("Hello")
                                .frame(width: reader.size.width, height: reader.size.height)
                                .background(Color.red)
                                .id(1)
                            
                            Text("World")
                                .frame(width: reader.size.width, height: reader.size.height)
                                .background(Color.yellow)
                                .id(2)
                        }
                        .onChange(of: scrollTarget) { target in
                            withAnimation {
                                proxy.scrollTo(target, anchor: .center)
                            }
                        }
                    }
                }
                .disabled(true)
            }
            
            Button("Click Me") {
                scrollTarget = (scrollTarget != 2) ? 2 : 1
            }
            .padding(20)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewInterfaceOrientation(.landscapeLeft)
    }
}
