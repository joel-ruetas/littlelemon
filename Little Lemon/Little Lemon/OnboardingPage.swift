//
//  OnboardingPage.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-24.
//

import Foundation
import SwiftUI

struct OnboardingPage: Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var imageName: String
}

let onboardingPages = [
    OnboardingPage(title: "Little lemon", description: "Discover the best food from our restaurant.", imageName: "Hero image"),
    OnboardingPage(title: "Order Easily", description: "Order your favorite meals with just a few taps.", imageName: "Greek salad"),
    OnboardingPage(title: "Fast Delivery", description: "Get your food delivered to your doorstep quickly.", imageName: "Lemon dessert")
]
