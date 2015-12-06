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
    
    private var myWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // WebViewを生成.
        myWebView = UIWebView()
        
        // Delegateを設定する.
        myWebView.delegate = self
        
        // WebViewのサイズを設定する.
        myWebView.frame = self.view.bounds
        
        // Viewに追加する.
        self.view.addSubview(myWebView)
        
        // URLを設定する.
        let url: NSURL = NSURL(string: "http://www.apple.com")!
        
        // リクエストを作成する.
        let request: NSURLRequest = NSURLRequest(URL: url)
        
        // リクエストを実行する.
        myWebView.loadRequest(request)
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