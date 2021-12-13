//
//  UnitsViewController.swift
//  Project
//
//  Created by Monica Girgis Kamel on 05/12/2021.
//

import UIKit

class UnitsViewController: BaseViewController {

    @IBOutlet weak var unitsTableView: UITableView!

    var units: Unit?
    var token: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        setupUI()
    }
    
    private func setupUI(){
        unitsTableView.register(UINib(nibName: String(describing: UnitTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: UnitTableViewCell.self))
    }
    
    private func fetchData(){
        guard let token = token else { return}
        fetchToken(accessToken: token) { [weak self] user in
            let params = "\"spec\":{" + Spec().dictionary.queryString + "}," + Params().dictionary.queryString
            APIRoute.fetchRequest(clientRequest: .GetUnits(params: params, id: user.eid), decodingModel: Unit.self) { [weak self] response in
                switch response{
                case .success(let result):
                    self?.units = result
                    self?.unitsTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? SensorValuesViewController, let queryItems = sender as? (Int, String) else { return}
        vc.unitId = queryItems.0
        vc.accessToken = queryItems.1
    }
}

extension UnitsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return units?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UnitTableViewCell.self), for: indexPath) as! UnitTableViewCell
        cell.setData(unit: units?.items[indexPath.row] ?? UnitModel())
        
        cell.getValues = { [weak self] in
            guard let token = self?.token else { return}
            self?.performSegue(withIdentifier: "showSensorValues", sender: (self?.units?.items[indexPath.row].id, token))
        }
        return cell
    }
}
