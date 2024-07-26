//
//  UserProfile.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-21.
//

import SwiftUI

struct UserProfile: View {
    
    let firstName = UserDefaults.standard.string(forKey: kFirstName) ?? ""
    let lastName = UserDefaults.standard.string(forKey: kLastName) ?? ""
    let email = UserDefaults.standard.string(forKey: kEmail) ?? ""
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView {
            VStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 100)

                Text("Personal Information")
                    .font(.custom("MarkaziText-Medium", size: 64))
                    .fontWeight(.medium)
                    .foregroundColor(Color("Highlight 2"))
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)

                Spacer()

                VStack(spacing: 16) {
                    Image("profile-image-placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.bottom, 16)
                    
                    Text("First Name: \(firstName)")
                        .font(.custom("Karla-Medium", size: 18))
                        .fontWeight(.medium)
                        .padding(.horizontal, 20)
                    
                    Text("Last Name: \(lastName)")
                        .font(.custom("Karla-Medium", size: 18))
                        .fontWeight(.medium)
                        .padding(.horizontal, 20)
                    
                    Text("Email: \(email)")
                        .font(.custom("Karla-Medium", size: 18))
                        .fontWeight(.medium)
                        .padding(.horizontal, 20)
                }

                Spacer()

                Button(action: {
                    let persistenceController = PersistenceController.shared
                    persistenceController.clear()

                    UserDefaults.standard.set(false, forKey: kIsLoggedIn)
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("Logout")
                        .font(.custom("Karla-Medium", size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Primary 1"))
                        .cornerRadius(16)
                        .padding(.horizontal, 20)
                }
                .padding(.top, 24)

                Spacer()
            }
        }
    }
}

#Preview {
    UserProfile()
}
