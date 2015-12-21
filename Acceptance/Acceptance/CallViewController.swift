//
//  ViewController.swift
//  Acceptance
//
//  Created by 根東秀都 on 2015/12/19.
//  Copyright © 2015年 shuto kondo. All rights reserved.
//

import UIKit

class CallViewController: UIViewController {
    @IBOutlet weak var numberField: UITextField!
    
    let phone:Phone = Phone()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.blackColor()
        self.phone.login()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnCall(sender: AnyObject) {
        let params:Dictionary<String, String> = ["To": numberField.text!]
        phone.connectWithParams(params: params)
    }

    @IBAction func hungUp(sender: AnyObject) {
        phone.connection.disconnect()
    }
}

