//
//  ViewController.swift
//  HWThree_ColorSetting
//
//  Created by Anton Kondratenko on 01.06.2023.
//

import UIKit

protocol ColorViewControllerDelegate{
    func changeColor(_ color: UIColor)
}

class ColorViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var colorView: UIView!
    @IBOutlet var redCounter: UILabel!
    @IBOutlet var greenCounter: UILabel!
    @IBOutlet var blueCounter: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    
    var delegate: ColorViewControllerDelegate!
    var viewColor: UIColor!
    
//MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setStartSlidersPosition()
        setStartCounterValue()
        setStartTextFieldValue()
        setToolBarWithButton()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        colorView.layer.cornerRadius = 10
        colorView.backgroundColor = viewColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @objc func doneToolBarButtonTapped() {
        view.endEditing(true)
    }
    
    //MARK: - IBActions
    @IBAction func slidersAction(_ sender: UISlider) {
        viewColorChanged()
        if sender == redSlider {
            redCounter.text = String(format: "%.2f", redSlider.value)
            redTextField.text = String(format: "%.2f", redSlider.value)
        } else if sender == greenSlider {
            greenCounter.text = String(format: "%.2f", greenSlider.value)
            greenTextField.text = String(format: "%.2f", greenSlider.value)
        } else if sender == blueSlider {
            blueCounter.text = String(format: "%.2f", blueSlider.value)
            blueTextField.text = String(format: "%.2f", blueSlider.value)
        }
    }
    
    @IBAction func getCodeButtonTapped() {
        showAlert()
    }
    
    
    @IBAction func doneButtonTapped() {
        delegate.changeColor(colorView?.backgroundColor ?? .red)
        dismiss(animated: true)
    }
}

//MARK: - Private methods
private extension ColorViewController {
   func viewColorChanged() {
        let red = CGFloat(redSlider.value)
        let green = CGFloat(greenSlider.value)
        let blue = CGFloat(blueSlider.value)
        colorView.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    func colorToHex() -> String {
        let red = Int(redSlider.value * 255)
        let green = Int(greenSlider.value * 255)
        let blue = Int(blueSlider.value * 255)
        
        let colorCode = String(format: "#%02X%02X%02X", red, green, blue)
        return colorCode
    }
    
    func setStartSlidersPosition() {
        let colors = CIColor(color: viewColor)
        redSlider.value = Float(colors.red)
        greenSlider.value = Float(colors.green)
        blueSlider.value = Float(colors.blue)
    }
    
    func setStartCounterValue() {
        redCounter.text = String(format: "%.2f", redSlider.value)
        greenCounter.text = String(format: "%.2f", greenSlider.value)
        blueCounter.text = String(format: "%.2f", blueSlider.value)
    }
    
    func setStartTextFieldValue() {
        redTextField.text = String(format: "%.2f", redSlider.value)
        greenTextField.text = String(format: "%.2f", greenSlider.value)
        blueTextField.text = String(format: "%.2f", blueSlider.value)
    }
    
    func setToolBarWithButton() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneToolBarButtonTapped))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        toolbar.setItems([flexSpace, doneButton], animated: false)
        redTextField.inputAccessoryView = toolbar
        greenTextField.inputAccessoryView = toolbar
        blueTextField.inputAccessoryView = toolbar
    }
}

//MARK: - UIAlertController
extension ColorViewController {
    private func showAlert() {
        let colorCode = colorToHex()
        let alert = UIAlertController(title: "Color code", message: colorCode, preferredStyle: .alert)
        
        let copyAction = UIAlertAction(title: "Copy", style: .default) { _ in
            UIPasteboard.general.string = colorCode
        }
        alert.addAction(copyAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    private func textFieldAlert () {
        let alert = UIAlertController(title: "Oops", message: "Value must be between 0 and 1", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension ColorViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let number = Float(textField.text ?? ""), number <= 1.0 else { return textFieldAlert() }
        if textField == redTextField {
            redSlider.setValue(number, animated: true)
            redCounter.text = String(format: "%.2f", number)
        } else if textField == greenTextField {
            greenSlider.setValue(number, animated: true)
            greenCounter.text = String(format: "%.2f", number)
        } else if textField == blueTextField {
            blueSlider.setValue(number, animated: true)
            blueCounter.text = String(format: "%.2f", number) }
        viewColorChanged()
        }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }

}


