//
//  AppDelegate.swift
//  Yelp Pick
//
//  Created by Dhruv Patel on 7/29/19.
//  Copyright © 2019 Dhruv Patel. All rights reserved.
//

import UIKit
import Moya
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let window = UIWindow()
    let locationService = LocationService()
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let service = MoyaProvider<YelpService.BusinessesProvider>()
    let jsonDecoder = JSONDecoder()
    var coordinate: CLLocationCoordinate2D!
  
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool{
        
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        locationService.didChange = { [weak self] success in
            if success {
                self?.locationService.getLocation()
            }
        }
        
        locationService.newLocation = { [weak self] result in
            switch result {
            case .success(let location):
                self?.coordinate = location.coordinate
            case .failure(let Error):
                assertionFailure("Error getting the users location \(Error)")
            }
            
        }

        switch locationService.status {
        case .notDetermined, .denied, .restricted:
            let locationViewController = storyboard.instantiateViewController(withIdentifier: "LocationViewController") as? LocationViewController
            locationViewController?.delegate = self
            window.rootViewController = locationViewController
        default:
            let nav = storyboard.instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController
            
            window.rootViewController = nav
            locationService.getLocation()
          //  loadBusinesses()
        }
        
        window.makeKeyAndVisible()
        
        return true
    }
    
    public func loadBusinesses(/*with coordinate: CLLocationCoordinate2D,*/ key: String) {
        service.request(.search(lat: coordinate.latitude, long: coordinate.longitude, key: key)) { [weak self]  (result) in
            guard let strongSelf = self else {return}
            switch result {
            case .success(let response):
                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
                print(root)
                let viewModels = root?.businesses.compactMap(RestaurantListViewModel.init)
                print(viewModels?.randomElement()!)
                if let nav = strongSelf.window.rootViewController as? UINavigationController,
                    let searchViewController = nav.topViewController as?  SearchViewController{
                    
                }
            
            case .failure(let error):
                print("Error; \(error)")
            }
        }
    }
}

extension AppDelegate: LocationActions {
    func didTapAllow() {
        
        locationService.requestLocationAutorization()
    }
}


