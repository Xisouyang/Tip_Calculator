//
//  ViewController.swift
//  TipCalculatorStarter
//
//  Created by Chase Wang on 9/19/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Connecting Storyboard elements to code via IBOutlets/IBActions
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var themeSwitch: UISwitch!
    
    @IBOutlet weak var inputCardView: UIView!
    @IBOutlet weak var billAmountTextField: BillAmountTextField!
    @IBOutlet weak var tipPercentageSC: UISegmentedControl!
    
    @IBOutlet weak var outputCardView: UIView!
    @IBOutlet weak var tipAmountTitleLabel: UILabel!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var totalAmountTitleLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
    @IBOutlet weak var resetButton: UIButton!

    //setup for status bar color
    var isDefaultStatusBar = true;
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDefaultStatusBar ? .default: .lightContent;
    }
    
    // MARK: - View Lifecycle
    
    //What occurs when app view first loads up
    override func viewDidLoad() {
        super.viewDidLoad();
        setupViews();
        setTheme(isDark: false);
        billAmountTextField.calculateButtonAction = {
            self.calculate();
        }
    }
    
    //updates UI appearance based on theme(light/dark). Dependent on switch.
    func setTheme(isDark: Bool){
        
        let theme = isDark ? ColorTheme.dark : ColorTheme.light;
        
        //updates status bar color depending on theme(light/dark)
        isDefaultStatusBar = theme.isDefaultStatusBar;
        setNeedsStatusBarAppearanceUpdate();
        
        view.backgroundColor = theme.viewControllerBackgroundColor;
        
        headerView.backgroundColor = theme.primaryColor;
        titleLabel.textColor = theme.titleTextColor;
        
        inputCardView.backgroundColor = theme.secondaryColor;
        
        billAmountTextField.tintColor = theme.accentColor;
        tipPercentageSC.tintColor = theme.accentColor;
        
        outputCardView.backgroundColor = theme.primaryColor;
        outputCardView.layer.borderColor = theme.accentColor.cgColor;
        
        tipAmountTitleLabel.textColor = theme.secondaryTextColor;
        totalAmountTitleLabel.textColor = theme.secondaryTextColor;
        
        tipAmountLabel.textColor = theme.secondaryTextColor;
        totalAmountLabel.textColor = theme.secondaryTextColor;
        
        resetButton.backgroundColor = theme.buttonColor;
        
    }
    
    //rounds out corners of certain UI elements, add shadow to header
    func setupViews() {
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1);
        headerView.layer.shadowOpacity = 0.1;
        headerView.layer.shadowColor = UIColor.black.cgColor;
        headerView.layer.shadowRadius = 35;
        
        inputCardView.layer.cornerRadius = 8;
        inputCardView.layer.masksToBounds = true;
        
        outputCardView.layer.cornerRadius = 8;
        outputCardView.layer.masksToBounds = true;
        outputCardView.layer.borderWidth = 1;
        outputCardView.layer.borderColor = UIColor.tcHotPink.cgColor;
        
        resetButton.layer.cornerRadius = 8;
        resetButton.layer.masksToBounds = true;
    }
    
    //logic to calculate tip based on user input
    func calculate() {
        
        //hides keyboard after calculate button is tapped
        if self.billAmountTextField.isFirstResponder {
            self.billAmountTextField.resignFirstResponder();
        }
        
        guard let billAmountText = self.billAmountTextField.text,
            let billAmount = Double(billAmountText)
            else {
                billAmountTextField.text = "$0.00";
                return;
        }
        
        let roundedBillAmount = (100 * billAmount).rounded() / 100;
        
        let tipPercent: Double;
        switch tipPercentageSC.selectedSegmentIndex {
        case 0:
            tipPercent = 0.15;
        case 1:
            tipPercent = 0.18;
        case 2:
            tipPercent = 0.20;
        default:
            preconditionFailure("unexpected index");
        }
        
        let tipAmount = tipPercent * roundedBillAmount;
        let roundedTipAmount = (100 * tipAmount).rounded() / 100;
        
        let totalAmount = roundedTipAmount + roundedBillAmount;
        
        self.billAmountTextField.text = String(format: "%.2f", roundedBillAmount);
        self.tipAmountLabel.text = String(format: "%.2f", roundedTipAmount);
        self.totalAmountLabel.text = String(format: "%.2f", totalAmount);
        
        print("Bill Amount: \(roundedBillAmount)");
        print("Rounded Tip Amount: \(roundedTipAmount)");
        print("Total Amount: \(totalAmount)");
    }
    
    //logic for reset button
    func clear() {
        
        if self.billAmountTextField.isFirstResponder {
            self.billAmountTextField.resignFirstResponder();
        }
        
        //makes sure user enters valid input
        guard let billAmountText = billAmountTextField.text,
              let billAmount = Double(billAmountText) else {return;}
        
        self.billAmountTextField.text = nil;
        tipPercentageSC.selectedSegmentIndex = 0;
        self.tipAmountLabel.text = "$0.00";
        self.totalAmountLabel.text = "$0.00";
    }
    
    @IBAction func themeToggled(_ sender: UISwitch) {
        setTheme(isDark: sender.isOn)
    }
    
    @IBAction func tipPercentageChanged(_ sender: UISegmentedControl) {
        self.calculate();
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        print("I'm tapped");
        clear();
    }
}

