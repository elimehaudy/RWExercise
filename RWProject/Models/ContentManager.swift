//
//  ArticleManager.swift
//  RWProject
//
//  Created by Eli Mehaudy on 17/12/2020.
//

import Foundation

struct ContentManager {
    
    let articlesURL = "https://raw.githubusercontent.com/raywenderlich/ios-interview/master/Practical%20Example/articles.json"
    let videosURL = "https://raw.githubusercontent.com/raywenderlich/ios-interview/master/Practical%20Example/videos.json"
    var delegate: ContentManagerDelegate?
    var a = [ContentData]()
        
    func performRequest(with urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    let article = parseJSON(safeData)
                    delegate?.didUpdateArticle(self, article: article!, completion: {
                        return article!.data!
//                                    .sorted(by: {($0.id)! < ($1.id)!}))!
                    })
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> ContentModel? {
        let decoder = JSONDecoder()
        do {
            let article = try decoder.decode(ContentModel.self, from: data)
            return article
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

protocol ContentManagerDelegate {
    func didUpdateArticle(_ articleManager: ContentManager, article: ContentModel, completion: () -> [ContentData])
    func didFailWithError(error: Error)
}
