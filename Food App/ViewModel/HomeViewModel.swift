//
//  HomeViewModel.swift
//  Food App
//
//  Created by Dmitriy Borisov on 25.01.2021.
//

import SwiftUI
import CoreLocation
import Firebase

class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    @Published var userLocation: CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    @Published var showMenu = false
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            print("Авторизован")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("Доступ закрыт")
            self.noLocation = true
        default:
            print("Неизвестный пользователь")
            self.noLocation = false
            locationManager.requestWhenInUseAuthorization()

        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.userLocation = locations.last
        self.extractLocation()
        
        self.login()
    }
    func extractLocation() {
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, error) in
            guard let safeData = res else {return}
            var address = ""
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            self.userAddress = address
        }
    }
    func login() {
        Auth.auth().signInAnonymously { (res, err) in
            if err != nil {
                print(err!.localizedDescription)
                return
            }
            print("Удача = \(res!.user.uid)")
        }
    }
}
