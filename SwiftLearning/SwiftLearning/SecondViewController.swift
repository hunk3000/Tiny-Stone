//
//  SecondViewController.swift
//  SwiftLearning
//
//  Created by Hunk on 14-6-16.
//  Copyright (c)
//

import UIKit

class SecondViewController: UIViewController {
    
    var titleLabel:UILabel?
    
    override func loadView() {
        super.loadView();
        
        titleLabel = UILabel()
//        titleLabel?.font = UIFont.systemFontOfSize(12.0)
//        titleLabel?.text = "Hello,world"
//        titleLabel?.textColor = UIColor.redColor()
        self.view.addSubview(titleLabel)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

