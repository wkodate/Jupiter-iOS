//
//  MasterViewController.swift
//  Jupiter
//
//  Created by wkodate on 2015/12/19.
//  Copyright © 2015年 wkodate. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    private var articles: Array<Article>! = []
    
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    override func viewDidLoad() {
        print("viewDidLoad")
        request()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title =  "なんJまとめのまとめ"
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green: 150/255, blue: 136/255, alpha: 1.0)
    }
    
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear")
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        print("didReceiveMemoryWarning")
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print("prepareForSegue")
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let detailController = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                print("article=" + articles[indexPath.row].description!)
                detailController.detailItem = articles[indexPath.row]
                detailController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                detailController.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - Table View
    
    /*
    Cellの総数を返すデータソースメソッド.
    Tableのセル数を指定
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView numberOfRowsInSection")
        // cell数
        //return objects.count
        return articles.count
    }
    
    /*
    Cellに値を設定するデータソースメソッド.
    各cellの設定
    */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("tableView cellForRowAtIndexPath")
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        //let object = objects[indexPath.row]
        print("indexPath.row=" + indexPath.row.description)
        let title = articles[indexPath.row].title
        cell.textLabel!.text = title
        return cell
    }
    
    // MARK: - Fetched results controller
    
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        print("controllerWillChangeContent")
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        print("controllerDidChangeContent")
        self.tableView.endUpdates()
    }
    
    func request() {
        print("request is called.")
        let url = NSURL(string: "http://www6178uo.sakura.ne.jp/jupiter/index.json")!
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let req = NSURLRequest(URL: url)
        // jsonデータをパース
        let task = session.dataTaskWithRequest(req, completionHandler: {
            (data, res, err) in
            let res = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
            if let dataFromString = res.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: dataFromString)
                for (_,subJson):(String, JSON) in json {
                    let title:String!  = subJson["title"].string
                    let url:String! = subJson["link"].string
                    let rssTitle:String! = subJson["rss_title"].string
                    let created:String! = subJson["date"].string
                    let imageUrl:String! = subJson["image"].string
                    let description:String! = subJson["description"].string
                    let article = Article(title: title, link: url, rssTitle: rssTitle, created: created, imageUrl: imageUrl, description: description)
                    print(article.title)
                    self.articles.append(article)
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        })
        task.resume()
    }

}

