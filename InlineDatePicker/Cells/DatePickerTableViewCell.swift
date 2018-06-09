//
//  DatePickerTableViewCell.swift
//  InlineDatePicker
//
//  Created by Rajtharan Gopal on 09/06/18.
//  Copyright © 2018 Rajtharan Gopal. All rights reserved.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell {

    let datePicker = UIDatePicker()
    
    // Reuser identifier
    class func reuseIdentifier() -> String {
        return "DatePickerTableViewCell"
    }
    
    // Cell height
    class func cellHeight() -> CGFloat {
        return 162.0
    }
    
    // Default init methods
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initView()
    }
    
    // Default code method
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView() {
        let screenWidth = UIScreen.main.bounds.size.width
        datePicker.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 162)
        contentView.addSubview(datePicker)
    }

}
