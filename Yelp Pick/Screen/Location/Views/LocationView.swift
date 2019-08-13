//
//  LocationView.swift
//  Yelp Pick
//
//  Created by Dhruv Patel on 8/7/19.
//  Copyright © 2019 Dhruv Patel. All rights reserved.
//

import UIKit

@IBDesignable class LocationView: BaseView {

    
    @IBOutlet weak var allowButton: UIButton!
    @IBOutlet weak var denyButton: UIButton!
    
    var didTapAllow: (()-> Void)?
    
    @IBAction func allowAction(_ sender: UIButton) {
        didTapAllow?()
        print("Locationfdasfkjsflk")
    }
    
    @IBAction func denyAction(_ sender: UIButton) {
        
    }
    


}
