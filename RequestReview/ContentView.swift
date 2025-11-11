//
//  ContentView.swift
//  RequestReview
//
//  Created by angelos on 06/11/2025.
//

import SwiftUI
import StoreKit
struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var reviewManager = ReviewManager()    
    var body: some View {
        VStack(spacing: 20) {
                   Text("Welcome to ReviewApp")
                       .font(.title)
                       .padding()

                   Button("Request Review Now") {
                       reviewManager.requestReviewIfNeeded()
                   }

                   Text("Reviews requested this year: \(reviewManager.requestsThisYear)")
                       .foregroundColor(.secondary)
               }
               .padding()
               .onChange(of: scenePhase) { newPhase in
                   if newPhase == .active {
                       reviewManager.checkAndRequestOnLaunch()
                   }
               }
        
    }
}

#Preview {
    ContentView()
}
