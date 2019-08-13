//
//  SearchView.swift
//  Yelp Pick
//
//  Created by Dhruv Patel on 8/8/19.
//  Copyright © 2019 Dhruv Patel. All rights reserved.
//

import UIKit

@IBDesignable class SearchView: BaseView {
    
    @IBOutlet weak var searchTermTextField: UITextField!
    @IBOutlet weak var pickButton: UIButton!
    @IBOutlet weak var pickRandomButton: UIButton!
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    

    
    
    @IBAction func pickAction(_ sender: UIButton) {
        
        appDelegate?.loadBusinesses(key: searchTermTextField.text ?? "")
        print("Button Ran")
        
    }
    @IBAction func pickRandomAction(_ sender: UIButton) {
        
    }


}
