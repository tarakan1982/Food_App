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
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    TextField("Поиск", text: $HomeModel.search)
                   
                }
                .padding(.horizontal)
                .padding(.top, 10)
                Divider()
                
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack(spacing: 25) {
                        ForEach(HomeModel.filtered) {item in
                            ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                ItemView(item: item)
                                HStack {
                                    Text("Беслпатная доставка")
                                        .foregroundColor(.white)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal)
                                        .background(Color("dimonPink"))
                                    Spacer(minLength: 0)
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Image(systemName: "plus")
                                            .foregroundColor(.white)
                                            .padding(10)
                                            .background(Color("dimonPink"))
                                            .clipShape(Circle())
                                    })
                                }
                                .padding(.trailing, 10)
                                .padding(.top, 10)
                            })
                            .frame(width: UIScreen.main.bounds.width - 30) //высоту всписал я от себя, так как ее в уроке не было но из-за этого был наплыв карочек товаров друг на друга

                        }
                    }
                    .padding(.top, 10)
                })
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
        .onChange(of: HomeModel.search, perform: { value in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if value == HomeModel.search && HomeModel.search != ""{
                    HomeModel.filterData()
                }
            }
            
            if HomeModel.search == "" {
                withAnimation(.linear) {
                    HomeModel.filtered = HomeModel.items
                }
            }
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
