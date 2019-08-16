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
    
    weak var delegete: ListActions?
    var didPickAction: (()-> Void)?
    
    
    @IBAction func pickAction(_ sender: UIButton) {
        didPickAction?()
        appDelegate?.loadBusinesses(key: searchTermTextField.text ?? "")
        print("Button Ran")

        
    }
    @IBAction func pickRandomAction(_ sender: UIButton) {
        didPickAction?()
        appDelegate?.loadBusinesses(key: "" ?? "")
        
    }


}
