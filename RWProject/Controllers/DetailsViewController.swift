//
//  DetailsViewController.swift
//  RWProject
//
//  Created by Eli Mehaudy on 21/12/2020.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    
    var selectedContent: ContentData?
    
    override func viewDidLoad() {
        idLabel.text = selectedContent?.attributes?.released_at
    }
}
