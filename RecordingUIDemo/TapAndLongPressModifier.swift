//
//  TapAndLongPressModifier.swift
//  RecordingUIDemo
//
//  Created by Bhargav Agravat on 19/10/25.
//

import SwiftUI

struct TapAndLongPressModifier: ViewModifier {
    @State private var isLongPressing = false
    @State private var isLongPressactive: Bool = false

    let tapAction: (()->())
    let longPressAction: (()->())
    let stopLongPressAction: (()->())
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isLongPressing ? 0.9 : 1.0)
            .onLongPressGesture(minimumDuration: 0.5, pressing: { (isPressing) in
                withAnimation {
                    isLongPressing = isPressing
                    print("isLongPressing \(isLongPressing)")
                    if self.isLongPressactive {
                        self.isLongPressactive = false
                        print("Long press stop")
                        stopLongPressAction()
                    }
                }
            }, perform: {
                print("Long press start")
                self.isLongPressactive = true
                longPressAction()
            })
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        print("Single Tap")
                        tapAction()
                    }
            )
    }
}
