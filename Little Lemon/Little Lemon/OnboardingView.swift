//
//  OnboardingView.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @AppStorage("isOnboarding") var isOnboarding: Bool = true

    var body: some View {
        VStack {
            ZStack {
                Color("Primary 1")
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: UIScreen.main.bounds.height * 0.75)

                VStack(spacing: 20) {
                    Text(onboardingPages[currentPage].title)
                        .font(.custom("MarkaziText-Medium", size: 64))
                        .fontWeight(.medium)
                        .foregroundColor(Color("Primary 2"))
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                        .padding(.horizontal, 20)

                    Image(onboardingPages[currentPage].imageName)
                        .resizable()
                        .frame(width: 300, height: 300)
                        .clipped()
                        .padding(.top, 20)
                    
                    Text(onboardingPages[currentPage].description)
                        .font(.custom("Karla", size: 20))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)

                    Spacer()
                }
                .tag(onboardingPages.firstIndex(where: { $0.id == onboardingPages[currentPage].id }) ?? 0)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))

            HStack(spacing: 20) {
                // Previous Button
                if currentPage > 0 {
                    Button(action: {
                        if currentPage > 0 {
                            currentPage -= 1
                        }
                    }) {
                        Text("Previous")
                            .font(.custom("Karla-Medium", size: 18))
                            .fontWeight(.medium)
                            .foregroundColor(Color("Highlight 2"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("Highlight 1"))
                            .cornerRadius(10)
                    }
                }

                // Next Button
                Button(action: {
                    if currentPage < onboardingPages.count - 1 {
                        currentPage += 1
                    } else {
                        isOnboarding = false
                    }
                }) {
                    Text(currentPage < onboardingPages.count - 1 ? "Next" : "Get Started")
                        .font(.custom("Karla-Medium", size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Primary 1"))
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 32)
            .padding(.bottom, 32)
        }
    }
}

#Preview {
    OnboardingView()
}
