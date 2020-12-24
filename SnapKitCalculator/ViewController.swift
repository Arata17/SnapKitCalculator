//
//  ViewController.swift
//  SnapKitCalculator
//
//  Created by Мирас on 12/19/20.
//

import SnapKit

enum ButtonColors {
    static let numberColor = UIColor(red: 65/255, green: 70/255, blue: 77/255, alpha: 1)
    static let topRowOperationsColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
    static let operationsColor = UIColor(red: 240/255, green: 127/255, blue: 90/255, alpha: 1)
}

class ViewController: UIViewController {
    
    private var isStartedNewNumber = true
    
    private var calculatorLogic = CalculatorLogic()
    
    private var displayValue: Double {
        get {
            guard let number = Double(textLabel.text!) else {
                fatalError("Error converting label text to double")
            }
            return number
        }
        set {
            textLabel.text = String(newValue)
        }
    }
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "0"
        label.font = .systemFont(ofSize: 50)
        label.textAlignment = .right
        label.numberOfLines = 0
        return label
    }()
    
    //MARK: - First Row Stack View
    private let firstRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("AC", for: .normal)
        button.backgroundColor = ButtonColors.topRowOperationsColor
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(calcButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let plusMinusButton: UIButton = {
        let button = UIButton()
        button.setTitle("+/-", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.topRowOperationsColor
        button.addTarget(self, action: #selector(calcButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let percentageButton: UIButton = {
        let button = UIButton()
        button.setTitle("%", for: .normal)
        button.backgroundColor = ButtonColors.topRowOperationsColor
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(calcButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let divisionButton: UIButton = {
        let button = UIButton()
        button.setTitle("÷", for: .normal)
        button.backgroundColor = ButtonColors.operationsColor
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(calcButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Second Row Stack View
    private let secondRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let numberSevenButton: UIButton = {
        let button = UIButton()
        button.setTitle("7", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.numberColor
        button.addTarget(self, action: #selector(numButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let numberEightButton: UIButton = {
        let button = UIButton()
        button.setTitle("8", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.numberColor
        button.addTarget(self, action: #selector(numButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let numberNineButton: UIButton = {
        let button = UIButton()
        button.setTitle("9", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.numberColor
        button.addTarget(self, action: #selector(numButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let multiplyButton: UIButton = {
        let button = UIButton()
        button.setTitle("×", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.operationsColor
        button.addTarget(self, action: #selector(calcButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Third Row Stack View
    private let thirdRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let numberFourButton: UIButton = {
        let button = UIButton()
        button.setTitle("4", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.numberColor
        button.addTarget(self, action: #selector(numButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let numberFiveButton: UIButton = {
        let button = UIButton()
        button.setTitle("5", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.numberColor
        button.addTarget(self, action: #selector(numButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let numberSixButton: UIButton = {
        let button = UIButton()
        button.setTitle("6", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.numberColor
        button.addTarget(self, action: #selector(numButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let substractionButton: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.operationsColor
        button.addTarget(self, action: #selector(calcButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Fourth Row Stack View
    private let fourthRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let numberOneButton: UIButton = {
        let button = UIButton()
        button.setTitle("1", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.numberColor
        button.addTarget(self, action: #selector(numButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let numberTwoButton: UIButton = {
        let button = UIButton()
        button.setTitle("2", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.numberColor
        button.addTarget(self, action: #selector(numButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let numberThreeButton: UIButton = {
        let button = UIButton()
        button.setTitle("3", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.numberColor
        button.addTarget(self, action: #selector(numButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let additionButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.operationsColor
        button.addTarget(self, action: #selector(calcButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Fifth Row Stack View
    private let fifthRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let numberZeroButton: UIButton = {
        let button = UIButton()
        button.setTitle("0", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.numberColor
        button.addTarget(self, action: #selector(numButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let subStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let dotButton: UIButton = {
        let button = UIButton()
        button.setTitle(".", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.numberColor
        button.addTarget(self, action: #selector(numButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let equalButton: UIButton = {
        let button = UIButton()
        button.setTitle("=", for: .normal)
        button.titleLabel!.font = .systemFont(ofSize: 30)
        button.backgroundColor = ButtonColors.operationsColor
        button.addTarget(self, action: #selector(calcButtonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - mainStackView
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 1
        return stackView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    //MARK: - Layout Configuration
    
    private func layoutUI() {
        configureBackgroundView()
        configureTextLabel()
        configureFirstStackView()
        configureSecondStackView()
        configureThirdStackView()
        configureFouthStackView()
        configureSubStackView()
        configureFifthStackView()
        configureMainStackView()
    }
    
    private func configureBackgroundView() {
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.height.equalTo(150)
        }
    }
    
    private func configureTextLabel() {
        backgroundView.addSubview(textLabel)
        textLabel.snp.makeConstraints {
            $0.left.equalTo(backgroundView.snp.left).offset(10)
            $0.right.equalTo(backgroundView.snp.right).offset(-10)
            $0.bottom.equalTo(backgroundView.snp.bottom).offset(10)
            $0.height.equalTo(100)
        }
    }
    
    
    
    private func configureFirstStackView() {
        let buttonList = [deleteButton, plusMinusButton, percentageButton, divisionButton]
        for button in buttonList{
            firstRowStackView.addArrangedSubview(button)
        }
    }
    
    private func configureSecondStackView() {
        let buttonList = [numberSevenButton, numberEightButton, numberNineButton, multiplyButton]
        for button in buttonList{
            secondRowStackView.addArrangedSubview(button)
        }
    }
    
    private func configureThirdStackView() {
        let buttonList = [numberFourButton, numberFiveButton, numberSixButton, substractionButton]
        for button in buttonList{
            thirdRowStackView.addArrangedSubview(button)
        }
    }
    
    private func configureFouthStackView() {
        let buttonList = [numberOneButton, numberTwoButton, numberThreeButton, additionButton]
        for button in buttonList{
            fourthRowStackView.addArrangedSubview(button)
        }
    }
    
    private func configureSubStackView() {
        let buttonList = [dotButton, equalButton]
        for button in buttonList {
            subStackView.addArrangedSubview(button)
        }
    }
    
    private func configureFifthStackView() {
        let viewList = [numberZeroButton, subStackView]
        for view in viewList {
            fifthRowStackView.addArrangedSubview(view)
        }
    }
    
    private func configureMainStackView() {
        view.addSubview(mainStackView)
        let stackList = [firstRowStackView, secondRowStackView, thirdRowStackView, fourthRowStackView, fifthRowStackView]
        for stack in stackList {
            mainStackView.addArrangedSubview(stack)
        }
        mainStackView.snp.makeConstraints{
            $0.top.equalTo(backgroundView.snp.bottom).offset(0)
            $0.left.equalToSuperview().offset(0)
            $0.right.equalToSuperview().offset(0)
            $0.bottom.equalToSuperview().offset(0)
        }
    }
    
    //MARK: - Operations
    @objc private func calcButtonPressed(sender: UIButton!) {
        isStartedNewNumber = true
        
        calculatorLogic.setNumber(displayValue)
        
        if let calcMethod = sender.currentTitle, let result = calculatorLogic.calculate(calcMethod){
            displayValue = result
        }
    }
    
    @objc private func numButtonPressed(sender: UIButton!) {
        if let numValue = sender.currentTitle {
            
            if (isStartedNewNumber) {
                textLabel.text = numValue
                isStartedNewNumber = false
            } else {
                if numValue == "."{
                    
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return
                    }
                }
                textLabel.text! += numValue
            }
            
        }
    }
    
}

