//
//  MainViewController.swift
//  Jupiter
//
//  Created by wkodate on 2015/11/22.
//  Copyright © 2015年 wkodate. All rights reserved.
//

import UIKit
import SwiftyJSON

// 参考
// https://sites.google.com/a/gclue.jp/swift-docs/ni-yinki100-ios/uikit/006-uitableviewdeteburuwo-biao-shi
//
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    // Tableで使用する配列を設定する
    private var articles: Array<Article>! = []
    
    private var tableView: UITableView!
    
    override func viewDidLoad() {
        print("viewDidLoad is called.")
        request()
        super.viewDidLoad()
        
        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        // TableViewの生成する(status barの高さ分ずらして表示).
        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        // Cell名の登録をおこなう.
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        tableView.dataSource = self
        
        // Delegateを設定する.
        tableView.delegate = self
        
        // Viewに追加する.
        self.view.addSubview(tableView)
        
        // NavigationBarを取得する
        self.navigationController?.navigationBar
        
        // NavigationBarを表示する
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // NavigationItemの取得する.
        self.navigationItem
        
        // タイトルを設定する.
        self.navigationItem.title = "なんJまとめのまとめ"
        
        // 背景色の変更
        let color = UIColor(red: 0/255, green: 150/255, blue: 136/255, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor = color
    }
    
    /*
    Cellが選択された際に呼び出されるデリゲートメソッド.
    cellが選択されたときの挙動
    */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("tableView.didSelectRowAtIndexPath called.")
        print("Num: \(indexPath.row)")
        print("Value: \(self.articles[indexPath.row].title)")
        // WebViewContollerに遷移
        let webViewController: WebViewController = WebViewController()
        webViewController.articleLink = articles[indexPath.row].link
        webViewController.articleTitle = articles[indexPath.row].title
        self.navigationController?.pushViewController(webViewController, animated: true)
    }

    /*
    Cellの総数を返すデータソースメソッド.
    Tableのセル数を指定
    */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView.numberOfRowsInSection is called.")
        return articles.count
    }
    
    /*
    Cellに値を設定するデータソースメソッド.
    各cellの設定
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("tableView.cellForRowAtIndexPath is called.")
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        // Cellに値を設定する.
        cell.textLabel!.text = articles[indexPath.row].title
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func request() {
        print("request is called.")
        let url = NSURL(string: "http://www6178uo.sakura.ne.jp/jupiter/index.json")!
        //let url = NSURL(string: "http://hoge.com")!
        
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let req = NSURLRequest(URL: url)
        // jsonデータをパース
        let task = session.dataTaskWithRequest(req, completionHandler: {
            (data, res, err) in
            let res = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
            if let dataFromString = res.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: dataFromString)
                for (index,subJson):(String, JSON) in json {
                    let title:String!  = subJson["title"].string
                    let url:String! = subJson["link"].string
                    let rssTitle:String! = subJson["rss_title"].string
                    let created:String! = subJson["date"].string
                    let imageUrl:String! = subJson["image"].string
                    let description:String! = subJson["description"].string
                    let article = Article(title: title, link: url, rssTitle: rssTitle, created: created, imageUrl: imageUrl, description: description)
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

