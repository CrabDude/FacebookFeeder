//
//  SettingsViewController.swift
//  Facebook
//
//  Created by Adam Crabtree on 2/15/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit


let filterMap = ["Links":"link","Photos":"photo","Videos":"video","Statuses":"status"]

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var closeButton: UIBarButtonItem!
    @IBOutlet weak var applyButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    var selectedCellType = ""
    var delegate: ContentTypeFilter?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "SettingsCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        
        closeButton.target = self
        closeButton.action = Selector("closeTapped:")
        applyButton.target = self
        applyButton.action = Selector("applyTapped:")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("Loading cell: %@", indexPath.row)
        if let cell = tableView.dequeueReusableCellWithIdentifier("SettingsCell") as? SettingsCell {
            cell.switchView.addTarget(self, action: Selector("switchStateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
            switch indexPath.row {
            case 0:
                cell.labelView.text = "Links"
            case 1:
                cell.labelView.text = "Statuses"
            case 2:
                cell.labelView.text = "Photos"
            case 3:
                cell.labelView.text = "Videos"
            default:
                cell.labelView.text = ""
            }
            return cell
        }

        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func closeTapped(sender: UIButton!) {
        close()
    }
    
    func switchStateChanged(sender:UISwitch!) {
        println("toggleSwitches")
        if !sender.on {
            selectedCellType = ""
            return
        }
        let cells = tableView.visibleCells()
        for cell in cells {
            if let cell = cell as? SettingsCell {
                println(cell.switchView)
                if sender == cell.switchView {
                    selectedCellType = cell.labelView.text!
                } else {
                    cell.switchView.setOn(false, animated: true)
                }
            }
        }
    }
    
    func applyTapped(sender: UIButton!) {
        println("applyTapped \(selectedCellType)")
        self.delegate?.filter(filterMap[selectedCellType])
        close()
    }
    
    func close() {
        self.dismissViewControllerAnimated(true, completion:{})
    }
}

protocol ContentTypeFilter {
    func filter(filterType: String?)
}