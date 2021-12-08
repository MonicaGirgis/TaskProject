//
//  UnitsViewController.swift
//  Project
//
//  Created by Monica Girgis Kamel on 05/12/2021.
//

import UIKit

class UnitsViewController: UIViewController {

    @IBOutlet weak var unitsTableView: UITableView!
    
    var sid: String?
    var units: Unit?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        setupUI()
    }
    
    private func setupUI(){
        unitsTableView.register(UINib(nibName: String(describing: UnitTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: UnitTableViewCell.self))
    }
    
    private func fetchData(){
        guard let sid = sid else {
            return
        }
        let params = "\"spec\":{" + SpecModel().spec.dictionary.queryString + "}," + Params().dictionary.queryString
        APIRoute.fetchRequest(clientRequest: .GetUnits(params: params, id: sid), decodingModel: Unit.self) { [weak self] response in
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

extension UnitsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return units?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UnitTableViewCell.self), for: indexPath) as! UnitTableViewCell
        cell.setData(unit: units?.items[indexPath.row] ?? UnitModel())
        return cell
    }
}
