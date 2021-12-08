//
//  webViewController.swift
//  Project
//
//  Created by Monica Girgis Kamel on 05/12/2021.
//

import UIKit
import WebKit

class webViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    let startURL = URL(string: "http://gps.tawasolmap.com/login.html")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        guard let url = startURL else {return}
        webView.load(URLRequest(url: url))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navVC = segue.destination as? UINavigationController, let vc = navVC.topViewController as? UserInformationViewController, let token = sender as? String else { return}
        vc.accessToken = token
    }
}

extension webViewController: WKUIDelegate, WKNavigationDelegate{
    
   func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       if let url = webView.url, let token = url.queryParameters?.first(where: { $0.key == "access_token"})?.value{
            self.performSegue(withIdentifier: "showUserInformation", sender: token)
        }
    }
}
