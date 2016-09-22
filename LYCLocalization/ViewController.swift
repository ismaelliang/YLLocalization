//
//  ViewController.swift
//  LYCLocalization
//
//  Created by  Ismael Liang on 21/09/16.
//  Copyright © 2016 Yuchen Liang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var textLabel: UILabel!
    @IBOutlet var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refreshLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "English"
        } else {
            cell.textLabel?.text = "中文"
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            LYCLocalization.defaultTool.curLang = "en"
        } else {
            LYCLocalization.defaultTool.curLang = "zh-Hans"
        }
        
        refreshLabel()
    }
    
    func refreshLabel() {
    
        textLabel.text = "awesome".localized()
    
    }
    
}

