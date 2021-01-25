//
//  Home.swift
//  Food App
//
//  Created by Dmitriy Borisov on 25.01.2021.
//

import SwiftUI

struct Home: View {
    
    @StateObject var HomeModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                HStack(spacing: 15) {
                    Button(action: {
                        withAnimation(.easeIn) {HomeModel.showMenu.toggle()}
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(Color("dimonPink"))
                    })
                
                    Text(HomeModel.userLocation == nil ? "Определение позиции" : "Доставка в")
                    .foregroundColor(.black)
                    Text(HomeModel.userAddress)
                    .font(.caption)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("dimonPink"))
                    Spacer(minLength: 0)
                }
                .padding([.horizontal, .top])

                Divider()
                HStack(spacing: 15) {
                    TextField("Поиск", text: $HomeModel.search)
                    if HomeModel.search != "" {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(.gray)
                        })
                        .animation(.easeIn)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
                Divider()
                Spacer()
            }
            
            HStack {
                Menu(homeData: HomeModel)
                    .offset(x: HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                Spacer(minLength: 0)
            }
            .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
                            .onTapGesture(perform: {
                                withAnimation(.easeIn) {HomeModel.showMenu.toggle()}
                            })
            )
            
            if HomeModel.noLocation {
                Text("Дайте разрешение в настройках Вашего телефона, для определения геопозиции")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }
        }
        .onAppear(perform: {
            HomeModel.locationManager.delegate = HomeModel
            
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
