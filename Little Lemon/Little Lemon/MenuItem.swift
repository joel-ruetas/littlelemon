//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Joel Ruetas on 2024-07-22.
//

import Foundation

struct MenuItem: Decodable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: String
    let image: String
    let category: String
}
