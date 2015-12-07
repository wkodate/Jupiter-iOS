//
//  UIWebViewController.swift
//  Jupiter
//
//  Created by wkodate on 2015/11/29.
//  Copyright © 2015年 wkodate. All rights reserved.
//

import Foundation
import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    private var webView: UIWebView!

    var link : String = ""
    
    override func viewDidLoad() {
        print("viewDidLoad")
        super.viewDidLoad()
        
        // WebViewを生成.
        webView = UIWebView()
        
        // Delegateを設定する.
        webView.delegate = self
        
        // WebViewのサイズを設定する.
        webView.frame = self.view.bounds
        
        // Viewに追加する.
        self.view.addSubview(webView)
        
        // URLを設定する.
        let url: NSURL = NSURL(string: self.link)!
        
        // リクエストを作成する.
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        // リクエストを実行する.
        webView.loadRequest(request)
    }
    
    /*
    Pageがすべて読み込み終わった時呼ばれるデリゲートメソッド.
    */
    func webViewDidFinishLoad(webView: UIWebView) {
        print("webViewDidFinishLoad")
    }
    
    /*
    Pageがloadされ始めた時、呼ばれるデリゲートメソッド.
    */
    func webViewDidStartLoad(webView: UIWebView) {
        print("webViewDidStartLoad")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}