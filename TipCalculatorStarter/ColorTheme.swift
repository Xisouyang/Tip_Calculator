//
//  ColorTheme.swift
//  TipCalculatorStarter
//
//  Created by Xi Stephen Ouyang on 7/17/18.
//  Copyright © 2018 Make School. All rights reserved.
//

import Foundation
import UIKit

struct ColorTheme {
    let isDefaultStatusBar: Bool;
    let viewControllerBackgroundColor: UIColor;
    
    let titleTextColor: UIColor;
    let primaryColor: UIColor;
    let secondaryColor: UIColor;
    
    let primaryTextColor: UIColor;
    let secondaryTextColor: UIColor;
    
    let accentColor: UIColor;
    let buttonColor: UIColor;
    
    static let light = ColorTheme(isDefaultStatusBar: true, viewControllerBackgroundColor: .tcOffWhite, titleTextColor: .tcDarkBlue, primaryColor: .tcWhite, secondaryColor: .tcDarkBlue, primaryTextColor: .tcSeafoamGreen, secondaryTextColor: .tcCharcoal, accentColor: .tcHotPink,
                                  buttonColor: .tcDarkBlue);
    
    static let dark = ColorTheme(isDefaultStatusBar: false, viewControllerBackgroundColor: .tcAlmostBlack, titleTextColor: .tcWhite, primaryColor: .tcBlueBlack, secondaryColor: .tcMediumBlack, primaryTextColor: .lightGray, secondaryTextColor: .tcWhite, accentColor: .lightGray, buttonColor: .tcBlueBlack);
}
