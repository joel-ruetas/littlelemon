//
//  Onboarding.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-21.
//

import SwiftUI

let kFirstName = "First Name key"
let kLastName = "Last Name key"
let kEmail = "Email key"
let kIsLoggedIn = "IsLoggedIn key"

struct Onboarding: View {
    
    @State private var isLoggedIn = false
    @State var showFormInvalidMessage = false
    @State var errorMessage = ""
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    EmptyView()
                }
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)

                Text("Sign Up")
                    .font(.custom("MarkaziText-Medium", size: 64))
                    .fontWeight(.bold)
                    .padding(.top, 8)

                TextField("First Name", text: $firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.custom("Karla-Medium", size: 18))
                    .fontWeight(.medium)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                TextField("Last Name", text: $lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.custom("Karla-Medium", size: 18))
                    .fontWeight(.medium)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.custom("Karla-Medium", size: 18))
                    .fontWeight(.medium)
                    .keyboardType(.emailAddress)
                    .textContentType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                Button(action: {
                    validateForm()
                }) {
                    Text("Register")
                        .font(.custom("Karla-Medium", size: 18))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "#495E57"))
                        .cornerRadius(16)
                }

                .padding(.horizontal, 20)
                .padding(.top, 24)
            }
            .alert(isPresented: $showFormInvalidMessage) {
                Alert(
                    title: Text("ERROR"),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("OK"))
                )
        }
        }
    }
    
    private func validateForm() {
        // customerFirstName and customerLastName must contain just letters
        let firstNameIsValid = isValid(name: firstName)
        let lastNameIsValid = isValid(name: lastName)
        let emailIsValid = isValid(email: email)
        
        guard firstNameIsValid && lastNameIsValid && emailIsValid
        else {
            var invalidFirstNameMessage = ""
            if firstName.isEmpty || !isValid(name: firstName) {
                invalidFirstNameMessage = "First Name can only contain letters and must have at least 3 characters\n\n"
            }
            
            var invalidLastNameMessage = ""
            if lastName.isEmpty || !isValid(name: lastName) {
                invalidLastNameMessage = "Last Name can only contain letters and must have at least 3 characters\n\n"
            }
            
            var invalidEmailMessage = ""
            if !email.isEmpty || !isValid(email: email) {
                invalidEmailMessage = "The e-mail is invalid and cannot be blank."
            }
            
            self.errorMessage = "Found these errors in the form:\n\n \(invalidFirstNameMessage)\(invalidLastNameMessage)\(invalidEmailMessage)"
            
            showFormInvalidMessage.toggle()
            return
        }
                
        if firstNameIsValid && lastNameIsValid && emailIsValid {
            // Save Customer information
            UserDefaults.standard.set(firstName, forKey: kFirstName)
            UserDefaults.standard.set(lastName, forKey: kLastName)
            UserDefaults.standard.set(email, forKey: kEmail)
            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
            
            // form is valid, proceed
            isLoggedIn = true
        }
    }
    
    func isValid(name: String) -> Bool {
        guard !name.isEmpty,
              name.count > 2
        else { return false }
        for chr in name {
            if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") && !(chr == " ") ) {
                return false
            }
        }
        return true
    }
    
    func isValid(email: String) -> Bool {
        guard !email.isEmpty else { return false }
        let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"
        let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)
        return emailValidationPredicate.evaluate(with: email)
    }
}

// Color extension to handle hex colors
extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        let r, g, b: Double
        let a: Double = 1.0

        if scanner.scanHexInt64(&hexNumber) {
            r = Double((hexNumber & 0xff0000) >> 16) / 255
            g = Double((hexNumber & 0x00ff00) >> 8) / 255
            b = Double(hexNumber & 0x0000ff) / 255
            self.init(.sRGB, red: r, green: g, blue: b, opacity: a)
            return
        }

        self.init(.sRGB, red: 1, green: 0, blue: 0, opacity: a)
    }
}

#Preview {
    Onboarding()
}
