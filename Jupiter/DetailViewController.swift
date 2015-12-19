//
//  DetailViewController.swift
//  Jupiter
//
//  Created by wkodate on 2015/12/19.
//  Copyright © 2015年 wkodate. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    private var webView:UIWebView!

    var detailItem: Article? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        print("configureView")
        // WebViewを生成.
        webView = UIWebView()
        // WebViewのサイズを設定する.
        webView.frame = self.view.bounds

        // Viewに追加する.
        self.view.addSubview(webView)

        // タイトルを設定
        self.title = self.detailItem!.title

        // URLを設定する.
        let url: NSURL = NSURL(string: self.detailItem!.link)!

        // リクエストを作成する.
        let request: NSURLRequest = NSURLRequest(URL: url)

        // リクエストを実行する.
        webView.loadRequest(request)

        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.title
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
