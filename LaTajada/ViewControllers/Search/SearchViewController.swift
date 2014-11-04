//
//  SearchViewController.swift
//  LaTajada
//
//  Created by Sebastián on 1/11/14.
//  Copyright (c) 2014 Sebastián. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
