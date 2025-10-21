//
//  ContentView.swift
//  RecordingUIDemo
//
//  Created by Bhargav Agravat on 19/10/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecordingViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 50) {
                Text("Microphone Toggle Demo")
                    .font(.title)
                    .bold()
                
                // Microphone button with dual interaction modes
                Image(systemName: viewModel.isRecording ? "mic.fill" : "mic")
                    .font(.system(size: 60))
                    .foregroundColor(viewModel.isRecording ? .red : .primary)
                    .buttonStyle(MicButtonStyle())
                    .modifier(
                        TapAndLongPressModifier(
                            tapAction: { viewModel.toggleRecording()
                            },
                            longPressAction: {
                                viewModel.handleLongPressBegan()
                            }, stopLongPressAction: {
                                viewModel.handleLongPressEnded()
                            })
                    )
                
                // Mode indicators
                VStack(spacing: 10) {
                    Text("Mode 1: Tap to Toggle")
                        .font(.headline)
                    Text("Tap once to start recording, tap again to stop")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("Mode 2: Press and Hold")
                        .font(.headline)
                        .padding(.top)
                    Text("Hold to record, release to stop")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
            
            // Toast notification
            if viewModel.showToast {
                Text(viewModel.toastMessage)
                    .padding()
                    .background(Color.secondary)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .transition(.opacity)
                    .animation(.easeInOut, value: viewModel.showToast)
                    .zIndex(1)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .bottom
                    )
                    .padding(.bottom, 25)
            }
        }
    }
}

struct MicButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
            .padding()
            .background(
                Circle()
                    .fill(Color.gray.opacity(0.2))
            )
    }
}

#Preview {
    ContentView()
}
