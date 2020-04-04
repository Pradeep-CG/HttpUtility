//
//  ViewController.swift
//  HttpUtility
//
//  Created by Pradeep on 04/04/20.
//  Copyright © 2020 Pradeep. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // JSON to swift conversion link: https://app.quicktype.io/
    // create api url https://www.mockable.io

    let empObj = Employee(_httpUtility: HttpUtility())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func getEmployee(_ sender: Any) {
        empObj.getEmployeeData()
    }
    
    @IBAction func getReports(_ sender: Any) {
        empObj.getReportData()
    }
    @IBAction func registerUser(_ sender: Any) {
        empObj.postApiData()
        
    }
    @IBAction func getUser(_ sender: Any) {
        
        empObj.getUserData()
    }
    
    
    
}

