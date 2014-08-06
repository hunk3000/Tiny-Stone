//
//  SecondViewController.swift
//  SwiftLearning
//
//  Created by Hunk on 14-6-16.
//  Copyright (c)
//

import UIKit

class SecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView!
    var titleLabel:UILabel!
    
    override func loadView() {
        super.loadView();
        
        tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFontOfSize(12.0)
        titleLabel.text = "Hello,world"
        titleLabel.textColor = UIColor.redColor()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let f = self.view.frame
        tableView.frame = CGRectMake(0, 0, f.size.width, f.size.height)
        
        titleLabel.frame = CGRectMake(0, 0, 200, 30)
        titleLabel.center = self.view.center;
    }
    
    override func viewDidAppear(animated: Bool)  {
        super.viewDidAppear(animated)
        
        HKAnimation.animationCubeFromLeft(self.view)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "CellId")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int  {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView!, titleForHeaderInSection section: Int) -> String! {
        return "Header Title".lowercaseString
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellId", forIndexPath: indexPath) as UITableViewCell
        
        cell.text = "This is cell \(indexPath.row)"
        
        return cell
        
    }
    

}

