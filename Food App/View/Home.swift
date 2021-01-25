//
//  Home.swift
//  Food App
//
//  Created by Dmitriy Borisov on 25.01.2021.
//

import SwiftUI

struct Home: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 15) {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "line.horizontal.3")
                        .font(.title)
                        .foregroundColor(Color("dimonPink"))
                })
            
            Text("Доставка в")
                .foregroundColor(.black)
            Text("Эппл")
                .font(.caption)
                .fontWeight(.heavy)
                .foregroundColor(Color("dimonPink"))
            }
            .padding([.horizontal, .top])
            Divider()
            Spacer()
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
