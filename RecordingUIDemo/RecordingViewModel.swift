//
//  RecordingViewModel.swift
//  RecordingUIDemo
//
//  Created by Bhargav Agravat on 19/10/25.
//

import Foundation
import Combine

class RecordingViewModel: ObservableObject {
    @Published var isRecording = false
    @Published var showToast = false
    @Published var toastMessage = ""
    
    private var toastWorkItem: DispatchWorkItem?

    func reset(){
        showToast = false
        toastMessage = ""
        
        // Cancel any ongoing toast message task if toggle is pressed again
        toastWorkItem?.cancel()
    }
    
    func toggleRecording() {
        reset()
        if isRecording {
            stopRecording(type: "Single click to")
        } else {
            startRecording(type: "Single click to")
        }
    }
    
    func startRecording(type: String) {
        isRecording = true
        showToast(message: "\(type) Recording started")
    }
    
    func stopRecording(type: String) {
        isRecording = false
        showToast(message: "\(type) Recording stopped")
    }
    
    func handleLongPressBegan() {
        if !isRecording {
            startRecording(type: "Long press to")
        }
    }
    
    func handleLongPressEnded() {
        if isRecording {
            stopRecording(type: "Long press to")
        }
    }
    
    private func showToast(message: String) {
        toastMessage = message
        showToast = true
        
        // Create a new DispatchWorkItem
        toastWorkItem = DispatchWorkItem {
            self.showToast = false
        }
        
        // Execute the work item after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: toastWorkItem!)
    }
}

