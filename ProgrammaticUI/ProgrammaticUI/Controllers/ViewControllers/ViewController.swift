//
//  ViewController.swift
//  ProgrammaticUI
//
//  Created by lijia xu on 8/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    //Views
    private lazy var baseNumInputField: UITextField = {
        let txField = UITextField()
        txField.keyboardType = .numberPad
        txField.textAlignment = .center
        txField.borderStyle = .roundedRect
        
        txField.placeholder = "Enter Base Here"
        
        return txField
    }()
    
    private lazy var outputLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.blue
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 28)
        
        return label
    }()
    
    
    //Properties
    let percentOptions: [Int] = [5, 10, 15, 20, 25]
    
    var buttonsStackView: UIStackView?
    
    let buttonsCornerRadius: CGFloat = 12
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        buttonsStackView = buttonsStackViewGenerator(percentOptions)
        
        layoutViews()
    }
    
    func layoutViews() {
        guard let buttonsStackView = buttonsStackView else { return }
        //stackView
        view.addSubview(buttonsStackView)
        buttonsStackView.centerX(inView: view)
        buttonsStackView.centerY(inView: view)
        buttonsStackView.setDimensions(
            height: view.frame.height * 0.5,
            width: view.frame.width * 0.8
        )
        
        //input
        view.addSubview(baseNumInputField)
        baseNumInputField.setDimensions(
            height: view.frame.height * 0.06,
            width: view.frame.width * 0.5
        )
        baseNumInputField.centerX(inView: view)
        baseNumInputField.anchor(bottom: buttonsStackView.topAnchor, paddingBottom: 15)
        
        //result
        view.addSubview(outputLabel)
        outputLabel.setDimensions(
            height: view.frame.height * 0.06,
            width: view.frame.width * 0.5
        )
        outputLabel.centerX(inView: view)
        outputLabel.anchor(top: buttonsStackView.bottomAnchor, paddingTop: 15)
        
    }///End of  layoutViews
    
    func buttonsStackViewGenerator(_ buttonNums: [Int]) -> UIStackView {
        
        let percentButtons = buttonNums.enumerated().map { (index, num) -> UIButton in
            let btn = UIButton()
            
            //properties
            btn.tag = num
            btn.backgroundColor = .red
            btn.setTitle("\(num) %", for: .normal)
            
            btn.addTarget(self, action: #selector(handlePercentButtonTapped), for: .touchUpInside)
            
            //visual
            btn.layer.cornerRadius = buttonsCornerRadius
            btn.alpha = 0.5 + 0.4 * CGFloat(index) / CGFloat(buttonNums.count - 1)
            
            return btn
        }///End of  buttons
        
        let stackView = UIStackView(arrangedSubviews: percentButtons)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        
        return stackView
        
    }///End of  buttonsGenerator
    
    // MARK: - Handle percent button tapped
    @objc func handlePercentButtonTapped(_ sender: UIButton) {
        guard let inputNum = Double(baseNumInputField.text ?? "") else { return }
        let tipsAmount = (Double(sender.tag) / 100.0) * inputNum
        
        outputLabel.text = "💳 $" + String(format: "%.2f", (inputNum + tipsAmount))
        
    }///End of  handlePercentButtonTapped

}///End of  VC

