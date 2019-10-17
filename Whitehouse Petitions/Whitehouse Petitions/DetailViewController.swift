//
//  DetailViewController.swift
//  Whitehouse Petitions
//
//  Created by Felix Lin on 10/16/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>

        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style>
                h1 {
                    font-size: 200%;
                    color: darkgreen;
                    font-family: 'Times New Roman', Times, serif;
                }

                p {
                    font-size: 150%;
                    color: blue;
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                }
            </style>
        </head>

        <body>
            <h1>\(detailItem.title)</h1>
            <p>\(detailItem.body)</p>
        </body>

        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
    
}
