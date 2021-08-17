//
//  ViewController.swift
//  ProgrammaticUI
//
//  Created by lijia xu on 8/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    //Views
    private lazy var textInputField: UITextField = {
        let txField = UITextField()
        txField.keyboardType = .numberPad
        txField.textAlignment = .center
        txField.borderStyle = .roundedRect
        
        txField.placeholder = "Enter Base Here"
        
        return txField
    }()
    
    private lazy var showMoreButton: UIButton = {
        let showMoreBtn = UIButton()
        showMoreBtn.tag = -1
        showMoreBtn.backgroundColor = .red
        showMoreBtn.layer.cornerRadius = buttonsCornerRadius
        showMoreBtn.setTitle("Show More", for: .normal)
        
        showMoreBtn.addTarget(self, action: #selector(handlePercentButtonTapped), for: .touchUpInside)
        
        return showMoreBtn
    }()
    
    private lazy var outputLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.blue
        label.backgroundColor = .red
        return label
    }()
    
    
    //Properties
    let percentOptions: [Int] = [5, 10, 15]
    
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
        view.addSubview(textInputField)
        textInputField.setDimensions(
            height: view.frame.height * 0.06,
            width: view.frame.width * 0.5
        )
        textInputField.centerX(inView: view)
        textInputField.anchor(bottom: buttonsStackView.topAnchor, paddingBottom: 15)
        
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
            btn.alpha = 0.5 + 0.3 * CGFloat(index) / CGFloat(buttonNums.count - 1)
            
            return btn
        }///End of  buttons
        
        let finalButtons = percentButtons + [showMoreButton]
        
        let stackView = UIStackView(arrangedSubviews: finalButtons)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.distribution = .fillEqually
        
        return stackView
        
    }///End of  buttonsGenerator
    
    // MARK: - Handle percent button tapped
    @objc func handlePercentButtonTapped(_ sender: UIButton) {

        UIView.animate(withDuration: 0.3) {
            self.buttonsStackView?.alpha = 0
        } completion: { _ in
            
            
            UIView.animate(withDuration: 0.3) {
                buttonsStackView.alpha = 1
            }completion: { _ in
                buttonsStackView.alpha = 1
                self.buttonsStackView = self.buttonsStackViewGenerator([10])
            }
            
        }///End of  first anim completion
        
    }///End of  handlePercentButtonTapped

}///End of  VC

