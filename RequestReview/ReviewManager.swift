//
//  ReviewManager.swift
//  RequestReview
//
//  Created by angelos on 06/11/2025.
//

import Foundation
import StoreKit
import SwiftUI
import Combine
class ReviewManager: ObservableObject {
    
    @AppStorage("reviewRequestsThisYear")  var requestsThisYear: Int = 0
    @AppStorage("reviewLastYear")  var lastYear: Int = 0

    var currentYear: Int {
        Calendar.current.component(.year, from: Date())
    }

    @MainActor func requestReviewIfNeeded() {
        resetIfNewYear()

        guard requestsThisYear < 3 else {
            print("Max review requests reached for this year.")
            return
        }

        if let scene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            AppStore.requestReview(in: scene)
            requestsThisYear += 1
        }
    }

    @MainActor func checkAndRequestOnLaunch() {
        // Example: randomly request on some launches
        if Bool.random() {
            requestReviewIfNeeded()
        }
    }

    private func resetIfNewYear() {
        if lastYear != currentYear {
            lastYear = currentYear
            requestsThisYear = 0
        }
    }
}
