//
//  BaseView.swift
//  Yelp Pick
//
//  Created by Dhruv Patel on 8/7/19.
//  Copyright © 2019 Dhruv Patel. All rights reserved.
//

import UIKit

@IBDesignable class BaseView: UIView {
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configure()
    }
    
    func configure(){
        
    }
}
