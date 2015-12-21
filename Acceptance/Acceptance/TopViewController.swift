//
//  TopViewController.swift
//  Acceptance
//
//  Created by 根東秀都 on 2015/12/20.
//  Copyright © 2015年 shuto kondo. All rights reserved.
//

import UIKit
import ChameleonFramework

class TopViewController: UIViewController {
    
    var pageMenu:CAPSPageMenu?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let color = UIColor.flatBlackColorDark()
        self.navigationController!.navigationBar.barTintColor = color.lightenByPercentage(0.1)
        self.setStatusBarStyle(UIStatusBarStyleContrast)
        
        self.title = "受付アプリ"
        
        var controllerArray:[UIViewController] = []
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("Call") as! CallViewController
        controller.title = "メンバー一覧"
        let controller2 = self.storyboard!.instantiateViewControllerWithIdentifier("History") as! HistoryViewController
        controller2.title = "通話履歴"
        controllerArray.append(controller)
        controllerArray.append(controller2)
        
        let parameters:[CAPSPageMenuOption] = [
            .UseMenuLikeSegmentedControl(true),
            .MenuItemSeparatorPercentageHeight(0.1),
            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .SelectionIndicatorColor(UIColor.whiteColor()),
            .MenuHeight(50.0),
            .MenuItemWidth(100.0),
            .SelectionIndicatorHeight(1)
        ]
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 50.0, self.view.frame.width, self.view.frame.height), pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
