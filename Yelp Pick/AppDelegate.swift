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
    var navigationController: UINavigationController?
  
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool{
        
          jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

        
        locationService.didChange = { [weak self] success in
            if success {
                self?.locationService.getLocation()
                guard let strongSelf = self else {return}
                if let nav = strongSelf.window.rootViewController as? UINavigationController,
                    let restaurantListViewController = nav.topViewController as? SearchViewController {
                } else if let nav = strongSelf.storyboard
                    .instantiateViewController(withIdentifier: "RestaurantNavigationController") as? UINavigationController {
                    strongSelf.navigationController = nav
                    strongSelf.window.rootViewController?.present(nav, animated: true) {
                        (nav.topViewController as? SearchViewController)?.delegate = self
                    }
                }
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
            self.navigationController = nav
            window.rootViewController = nav
            locationService.getLocation()
            (nav?.topViewController as? SearchViewController)?.delegate = self
          //  loadBusinesses()
        }
        
        window.makeKeyAndVisible()
        
        return true
    }
    
    func loadDetails(for viewController: UIViewController, withId id: String) {
        service.request(.details(id: id)) {  [weak self] (result) in
            switch result {
            case .success(let response):
                 guard let strongSelf = self else {return}
                 if let details = try? strongSelf.jsonDecoder.decode(Details.self, from: response.data) {
                    let detailsViewModel = DetailsViewModel(details: details)
                    (viewController as? DetailsFoodViewController)?.viewModel = detailsViewModel
                }
            case .failure(let error):
                print("Failed getting restaurant \(error)")
            }
            
        }
    }
    
    public func loadBusinesses(key: String) {
        service.request(.search(lat: coordinate.latitude, long: coordinate.longitude, key: key)) { [weak self]  (result) in
            guard let strongSelf = self else {return}
            switch result {
            case .success(let response):
                let root = try? strongSelf.jsonDecoder.decode(Root.self, from: response.data)
                let viewModels = root?.businesses.compactMap(RestaurantListViewModel.init)
                guard let detailsViewController = self?.storyboard.instantiateViewController(withIdentifier: "DetailsViewController") else { return }
                self?.navigationController?.pushViewController(detailsViewController, animated: true)
               
                strongSelf.loadDetails(for: detailsViewController, withId: (viewModels?.randomElement()!.id)!)
                if let nav = strongSelf.window.rootViewController as? UINavigationController,
                    let searchViewController = nav.topViewController as?  SearchViewController{
                }
                    
                
            case .failure(let error):
                print("Error; \(error)")
            }
        }
        
    }
}

extension AppDelegate: LocationActions, ListActions {
    func didTapAllow() {
        
        locationService.requestLocationAutorization()
    }
    
    func didPickAction() {
      
    }
    
    func didTapButton(_ viewController: UIViewController, viewModel: RestaurantListViewModel) {
        loadDetails(for: viewController, withId: viewModel.id)
    }
}



