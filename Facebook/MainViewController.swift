//
//  MainViewController.swift
//  FacebookDemoSwift
//
//  Created by Timothy Lee on 2/11/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ContentTypeFilter {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btn: UIBarButtonItem!
    var rawData: [JSON] = []
    var data: [JSON] = []
    var filter: String?
    lazy var settingsVC: SettingsViewController = {
        let vc = SettingsViewController(nibName: "SettingsViewController", bundle: nil)
        vc.delegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.FullScreen
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.registerNib(UINib(nibName: "PhotoCell", bundle: nil), forCellReuseIdentifier: "PhotoCell")
        tableView.registerNib(UINib(nibName: "StatusCell", bundle: nil), forCellReuseIdentifier: "StatusCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        
        navigationItem.rightBarButtonItem?.target = self
        navigationItem.rightBarButtonItem?.action = Selector("settingsTapped")

        reload()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reload() {
        FBRequestConnection.startWithGraphPath("/me/home", parameters: nil, HTTPMethod: "GET") { (connection: FBRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
            self.rawData = []
            for (key, value) in JSON(result)["data"] {
                if value["message"].string != nil || value["picture"].string != nil {
                    self.rawData.append(value)
                }
            }
            self.data = self.rawData
            self.tableView.reloadData()
        }
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
        let rowData = self.data[indexPath.row]
        let message = rowData["message"].string
        if let url = rowData["picture"].string, cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell") as? PhotoCell {
            cell.label.text = message
            cell.img.setImageWithURL(NSURL(string: url))
            return cell
        } else if let cell = tableView.dequeueReusableCellWithIdentifier("StatusCell") as? StatusCell {
            cell.label.text = message
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        
//        let vc = MovieDetailsViewController(nibName: "MovieDetailsViewController", bundle: nil)
//        vc.data = self.data?["movies"][indexPath.row]
//        if let cell = self.tableView.cellForRowAtIndexPath(indexPath) as? MovieCell {
//            vc.thumbnail = cell.movieImage?.image
//        }
//        
//        self.navigationController?.pushViewController(vc, animated: true)
    }

    func settingsTapped() {
        self.presentViewController(settingsVC, animated: true, completion: {})
    }
    
    func filter(filterType: String?) {
        println("filter \(filterType)")
        filter = filterType
        
        self.data = []
        for value in rawData {
            if let type = value["type"].string {
                if filter == nil {
                    self.data = self.rawData
                } else if type == filter {
                    self.data.append(value)
                }
            }
        }
        tableView.reloadData()
    }
}
