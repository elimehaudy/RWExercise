//
//  ViewController.swift
//  RWProject
//
//  Created by Eli Mehaudy on 07/12/2020.
//

import UIKit

class LibraryViewController: UITableViewController {

    let articleManager = ArticleManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleManager.performRequest()
    }
}

