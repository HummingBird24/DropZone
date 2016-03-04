//
//  ViewController.swift
//  DropZone
//
//  Created by Deion Long on 2/27/16.
//  Copyright © 2016 Deion Long. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let font = UIFont(name: "MarkerFelt-Thin", size: 20);
        let titleDict: NSDictionary = [NSFontAttributeName: font!, NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

