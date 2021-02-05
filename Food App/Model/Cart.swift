//
//  Cart.swift
//  Food App
//
//  Created by Dmitriy Borisov on 04.02.2021.
//

import SwiftUI

struct Cart: Identifiable {
    var id = UUID().uuidString
    var item: Item
    var quantity: Int
}
