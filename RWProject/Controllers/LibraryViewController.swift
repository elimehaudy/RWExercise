//
//  ViewController.swift
//  RWProject
//
//  Created by Eli Mehaudy on 07/12/2020.
//

import UIKit
import SDWebImage

class LibraryViewController: UITableViewController, ContentManagerDelegate {

    var contentManager = ContentManager()
    var artciclesContent: ContentModel?
    var videosContent: ContentModel?
    lazy var localData = [ContentData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentManager.delegate = self
        contentManager.performRequest(with: contentManager.articlesURL)
        contentManager.performRequest(with: contentManager.videosURL)
        tableView.register(UINib(nibName: "Cell", bundle: nil), forCellReuseIdentifier: "customCell")
        tableView.separatorStyle = .none
        
    }
    
    func didUpdateArticle(_ articleManager: ContentManager, article: ContentModel, completion: () -> [ContentData]) {
        localData += completion()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func sortContentArray(array: [ContentData]) {
        array.sorted(by: { $0.id! < $1.id!})
        for data in localData {
            print(data.id)
        }
        print(localData.count)
        
    }
    
//    @IBAction func sortButtonPressed(_ sender: UIBarButtonItem) {
//        localData = localData.sorted(by: {$0.id! < $1.id!})
//        tableView.reloadData()

//    }
//
    func didFailWithError(error: Error) {
        print("failed loading, \(error)")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! Cell
        cell.titleLabel.text = localData[indexPath.row].attributes?.name
        cell.descriptionLabel.text = localData[indexPath.row].attributes?.description_plain_text
        cell.titleLabel.sizeToFit()
        cell.descriptionLabel.sizeToFit()
        cell.cellView.layer.cornerRadius = 10
        if let url = URL(string: localData[indexPath.row].attributes?.card_artwork_url ?? "") {
            cell.cellImageView.sd_setImage(with: url, completed: nil)
        }
        cell.cellImageView.layer.cornerRadius = 8
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let destination = segue.destination as! DetailsViewController

            destination.selectedContent = localData[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetails", sender: self)
    }
}

