//
//  UserInformationViewController.swift
//  Project
//
//  Created by Monica Girgis Kamel on 05/12/2021.
//

import UIKit

class UserInformationViewController: BaseViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var getUnitsButton: UIButton!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var getAddressButton: UIButton!
    
    var accessToken: String?
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fetchData()
    }
    
    private func setupUI(){
        getUnitsButton.setBorderColor(color: .systemTeal, width: 2.0)
        getAddressButton.setBorderColor(color: .systemTeal, width: 2.0)
        
        getUnitsButton.isEnabled(false)
        getAddressButton.isEnabled(false)
    }
    
    private func fetchData(){
        guard let accessToken = accessToken else {
            return
        }
        fetchToken(accessToken: accessToken) { [weak self] user in
            guard let self = self else { return}
            self.user = user
            self.reloadData()
        }
    }
    
    private func fetchAddress(){
        guard let user = user else {
            return
        }
        let pos = Coords(lat: 24.771972, lon: 46.632892)
        APIRoute.fetchRequest(clientRequest: .GetAddress(position: pos, id: user.user.id), decodingModel: [String].self) { [weak self] response in
            switch response{
            case .success(let result):
                self?.showAlert(title: "Your address is", message: result.first ?? "")
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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? UnitsViewController, let token = sender as? String else { return}
        vc.token = accessToken
    }
    
    @IBAction func getUnitsAction(_ sender: Any) {
        guard let accessToken = accessToken else { return}
        performSegue(withIdentifier: "showUnits", sender: accessToken)
    }
    
    @IBAction func getAddressAction(_ sender: Any) {
        guard let accessToken = accessToken else { return}
        fetchToken(accessToken: accessToken) { [weak self] user in
            self?.user = user
            self?.fetchAddress()
        }
    }
    
}
