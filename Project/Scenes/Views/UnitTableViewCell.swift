//
//  UnitTableViewCell.swift
//  Project
//
//  Created by Monica Girgis Kamel on 06/12/2021.
//

import UIKit

class UnitTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longtitudeLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    

    func setData(unit: UnitModel){
        let titleAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.systemTeal]
        let dataAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular), NSAttributedString.Key.foregroundColor: UIColor.black]
        
        var attributedName = NSMutableAttributedString(string: "Name: ", attributes: titleAttributes)
        var attributedData = NSMutableAttributedString(string: unit.name, attributes: dataAttributes)
        attributedName.append(attributedData)
        nameLabel.attributedText = attributedName
        
        attributedName = NSMutableAttributedString(string: "Id: ", attributes: titleAttributes)
        attributedData = NSMutableAttributedString(string: "\(unit.id)", attributes: dataAttributes)
        attributedName.append(attributedData)
        idLabel.attributedText = attributedName
        
        attributedName = NSMutableAttributedString(string: "Latitude: ", attributes: titleAttributes)
        attributedData = NSMutableAttributedString(string: "\(unit.position.latitude)", attributes: dataAttributes)
        attributedName.append(attributedData)
        latitudeLabel.attributedText = attributedName
        
        attributedName = NSMutableAttributedString(string: "Longitude: ", attributes: titleAttributes)
        attributedData = NSMutableAttributedString(string: "\(unit.position.longitude)", attributes: dataAttributes)
        attributedName.append(attributedData)
        longtitudeLabel.attributedText = attributedName
        
        attributedName = NSMutableAttributedString(string: "Speed: ", attributes: titleAttributes)
        attributedData = NSMutableAttributedString(string: "\(unit.position.speed)", attributes: dataAttributes)
        attributedName.append(attributedData)
        speedLabel.attributedText = attributedName
    }
    
}
