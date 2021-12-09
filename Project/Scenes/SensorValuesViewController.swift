//
//  SensorValuesViewController.swift
//  Project
//
//  Created by Monica Girgis Kamel on 09/12/2021.
//

import UIKit

class SensorValuesViewController: BaseViewController {

    @IBOutlet weak var sensorsValuesTableView: UITableView!
    
    var unitId: Int?
    var accessToken: String?
    var sensorsValues: [String:Double]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    private func fetchData(){
        guard let accessToken = accessToken, let unitId = unitId else {
            return
        }
        fetchToken(accessToken: accessToken) { [weak self] user in
            APIRoute.fetchRequest(clientRequest: .CalculateSensorsValues(sid: user.eid, unitId: unitId), decodingModel: [String:Double].self) { [weak self] response in
                switch response{
                case .success(let values):
                    self?.sensorsValues = values
                    self?.sensorsValuesTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func setSensorsValues(with sensors: (String,Double))->NSMutableAttributedString{
        let titleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.systemTeal]
        let dataAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.black]
        
        let attributedName = NSMutableAttributedString(string: "Engine \(sensors.0): ", attributes: titleAttributes)
        let attributedData = NSMutableAttributedString(string: sensors.1 > 0 ? "ON" : "OFF", attributes: dataAttributes)
        attributedName.append(attributedData)
        return attributedName
    }
    
}

extension SensorValuesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sensorsValues?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.attributedText = setSensorsValues(with: Array(sensorsValues ?? [:])[indexPath.row])
        return cell
    }
    
}
