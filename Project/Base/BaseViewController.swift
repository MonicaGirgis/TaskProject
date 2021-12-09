//
//  BaseViewController.swift
//  Project
//
//  Created by Monica Girgis Kamel on 09/12/2021.
//

import UIKit

class BaseViewController: UIViewController {

    var didLoad: Bool = false
    private var timer = Timer()
    private var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func fetchToken(accessToken: String, completion: ((User)->())? = nil){
        guard !didLoad else{
            guard let user = user else { return}
            completion?(user)
            return
        }
        APIRoute.fetchRequest(clientRequest: .GetUserInformation(token: accessToken), decodingModel: User.self) { response in
            switch response{
            case .success(let result):
                self.didLoad = true
                self.user = result
                self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.invalidateTimer), userInfo: nil, repeats: false)
                completion?(result)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func invalidateTimer(){
        didLoad = false
        timer.invalidate()
    }
}
