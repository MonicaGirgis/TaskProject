//
//  UserInformationViewController.swift
//  Project
//
//  Created by Monica Girgis Kamel on 05/12/2021.
//

import UIKit

class UserInformationViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var getUnitsButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var getAddressButton: UIButton!
    @IBOutlet weak var calculateSensorsButton: UIButton!
    
    var accessToken: String?
    var user: User?
    private var didLoad: Bool = false
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fetchData()
    }
    
    private func setupUI(){
        getUnitsButton.setBorderColor(color: .systemTeal, width: 2.0)
        getAddressButton.setBorderColor(color: .systemTeal, width: 2.0)
        calculateSensorsButton.setBorderColor(color: .systemTeal, width: 2.0)
        
        getUnitsButton.isEnabled(false)
        getAddressButton.isEnabled(false)
        calculateSensorsButton.isEnabled(false)
    }
    
    private func fetchData(tokenLoaded: (()->())? = nil){
        guard let accessToken = accessToken else {
            return
        }
        APIRoute.fetchRequest(clientRequest: .GetUserInformation(token: accessToken), decodingModel: User.self) { [weak self] result in
            guard let self = self else { return}
            switch result{
            case .success(let user):
                self.user = user
                self.didLoad = true
                tokenLoaded?()
                self.timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.invalidateTimer), userInfo: nil, repeats: false)
                self.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchAddress(){
        guard let user = user else {
            return
        }
        let pos = Coords(lat: 24.771972, lon: 46.632892)
        APIRoute.fetchRequest(clientRequest: .GetAddress(position: pos, id: user.user.id), decodingModel: [String:Int].self) { [weak self] response in
            switch response{
            case .success(let result):
                self?.showAlert(message: result.first?.key ?? "")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func reloadData(){
        nameLabel.text = user!.user.name
        idLabel.text = String(describing: user!.user.id)
        getUnitsButton.isEnabled(true)
        getAddressButton.isEnabled(true)
        calculateSensorsButton.isEnabled(true)
    }
    
    @objc private func invalidateTimer(){
        didLoad = false
        timer.invalidate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? UnitsViewController, let id = sender as? String else { return}
        vc.sid = id
    }
    
    @IBAction func getUnitsAction(_ sender: Any) {
        guard didLoad else {
            fetchData { [weak self] in
                self?.performSegue(withIdentifier: "showUnits", sender: self?.user?.eid)
            }
            return
        }
        performSegue(withIdentifier: "showUnits", sender: user?.eid)
    }
    
    @IBAction func getAddressAction(_ sender: Any) {
        guard didLoad else {
            fetchData { [weak self] in
                self?.fetchAddress()
            }
            return
        }
        fetchAddress()
    }
    
    @IBAction func calculateSensorsAction(_ sender: Any) {
    }
}
