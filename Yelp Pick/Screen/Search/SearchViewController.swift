//
//  SearchViewController.swift
//  Yelp Pick
//
//  Created by Dhruv Patel on 8/8/19.
//  Copyright © 2019 Dhruv Patel. All rights reserved.
//

import UIKit

protocol ListActions: class {
    func didTapButton(_ viewController: UIViewController, viewModel: RestaurantListViewModel)
    func didPickAction()
}

class SearchViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var searchTermTextField: UITextField!
    
    weak var delegate: ListActions?


    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.didPickAction = {
            self.delegate?.didPickAction()
        }

        self.searchTermTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
