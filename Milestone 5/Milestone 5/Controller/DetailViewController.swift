//
//  DetailViewController.swift
//  Milestone 5
//
//  Created by Felix Lin on 11/16/19.
//  Copyright © 2019 Felix Lin. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webView: WKWebView!
    var detailItem: Country?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never

        guard let detailItem = detailItem else { return }

        let html = """
        <html>

        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <style>
                h1 {
                    font-size: 300%;
                    color: darkgreen;
                    font-family: 'Times New Roman', Times, serif;
                }

                p {
                    font-size: 150%;
                    color: blue;
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                }
        
                img {
                    max-width: 100%;
                    height: auto;
                    border: 1px solid #ddd;
                }
            </style>
        </head>

        <body>
            <h1>\(detailItem.name)</h1>
            <img src="\(detailItem.flag)">
            <p>Capital: \(detailItem.capital)</p>
            <p>Population: \(detailItem.population)</p>
        </body>

        </html>
        """

        webView.loadHTMLString(html, baseURL: nil)
    }

}
