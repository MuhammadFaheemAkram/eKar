//
//  VehichleDetailsTableViewCell.swift
//  eKar
//
//  Created by Faheem on 15/03/2023.
//

import UIKit

protocol VehichleDetailsCellDelegate: AnyObject {
    func didTapContractWorks()
}

class VehichleDetailsTableViewCell: BaseTableViewCell {
    
    //MARK: Properties
    private var isColorsAdded = false
    private var viewModel: VehicleDetailsViewModel!
    private let sliderInterval: Float = 3
    private var colorWidthHeight: CGFloat = 12
    weak var delegate: VehichleDetailsCellDelegate?
    
    //MARK: Outlets
    @IBOutlet weak var colorsStackView: UIStackView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var savingsLabel: UILabel!
    @IBOutlet weak var savingsView: UIView! {
        didSet {
            savingsView.layer.cornerRadius = 5
            
        }
    }
    
    @IBOutlet weak var contractLengthLabel: UILabel!
    @IBOutlet weak var bookingFeeLabel: UILabel!
    @IBOutlet weak var tenureSlider: UISlider! {
        didSet {
            tenureSlider.maximumValue = 9
            tenureSlider.minimumTrackTintColor = Colors.blueColor
            tenureSlider.minimumValue = 1
            tenureSlider.value = 1
            tenureSlider.isContinuous = true
            tenureSlider.setThumbImage(Image.circleIcon, for: .normal)
            tenureSlider.setThumbImage(Image.circleIcon, for: .highlighted)
        }
    }
    
    @IBOutlet weak var availableColorsLabel: UILabel!
    
    @IBOutlet weak var outerView: UIView! {
        didSet {
            outerView.backgroundColor = Colors.primaryColor
        }
    }
    
    @IBOutlet weak var howContractWorksView: UIView! {
        didSet {
            howContractWorksView.backgroundColor = .white
            howContractWorksView.layer.cornerRadius = 8
            howContractWorksView.layer.borderColor = Colors.blueColor?.cgColor
            howContractWorksView.layer.borderWidth = 2
        }
    }
    
    @IBOutlet weak var howContractWorkLabel: UILabel! {
        didSet {
            howContractWorkLabel.textColor = Colors.blueColor
        }
    }
    
    
    //MARK: Override Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tenureSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        colorsStackView.translatesAutoresizingMaskIntoConstraints = false
    }

        
    //MARK: Actions
    @objc
    func sliderValueChanged(_ sender: UISlider) {
        let roundedValue = roundToNearestInterval(sender.value, interval: sliderInterval)
        sender.value = roundedValue
    }
    
    @IBAction
    func howContractWorkAction(_ sender: UIButton) {
        self.delegate?.didTapContractWorks()
    }
    
    
    //MARK: Public Function
    func configureCell(viewModel: VehicleDetailsViewModel) {
        self.viewModel = viewModel
        
        yearLabel.text = viewModel.year
        priceLabel.attributedText = viewModel.getPriceText()
        contractLengthLabel.attributedText = viewModel.getContractLengthText(value: Int(tenureSlider.value))
        bookingFeeLabel.attributedText = viewModel.getBookingFeeText()
        addAvailableColorsInStackView()
    }
    
    
    /// This function calculates contract price from value which is selected.
    /// It will check the base prie and then apply a discount value from a dummy point
    /// - Parameter value: value of selected length
    func setContractLengthAndPrice(value: Int) {
        let discount = viewModel.basePrice * 0.03
        let percentage = floor(discount * Double(value))
        
        let monthOrMonths = value == 1 ? LocalizedKey.month.string : LocalizedKey.months.string
        let price = value == 1 ? viewModel.basePrice : viewModel.basePrice - percentage
        let formattedValue = Utils.getFormattedPrice(price: price)
        
        priceLabel.attributedText = Utils.getAttributedString(biggerString: formattedValue,
                                                              smallerString: "\(LocalizedKey.aed.string) / \(monthOrMonths)")
        
        savingsView.isHidden = value == 1
        
        let savingsFormattedValue = Utils.getFormattedPrice(price: percentage)
        savingsLabel.text = "SAVINGS OF AED \(savingsFormattedValue)"
        
        
        contractLengthLabel.attributedText = Utils.getAttributedString(biggerString: "\(value)",
                                                                       smallerString: monthOrMonths)
    }
    
    
    //MARK: Helper Functions
    private func addAvailableColorsInStackView() {
        ///Setting constraints for Colors StackView
        colorsStackView.leadingAnchor.constraint(equalTo: availableColorsLabel.trailingAnchor, constant: 8.0).isActive = true
        colorsStackView.topAnchor.constraint(equalTo: availableColorsLabel.topAnchor, constant: 8.0).isActive = true
        colorsStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0).isActive = true
        colorsStackView.heightAnchor.constraint(equalToConstant: colorWidthHeight).isActive = true
        
        let width = CGFloat(self.viewModel.exteriorColors.count) * colorWidthHeight
        let spacing = CGFloat(self.viewModel.exteriorColors.count) * 3.0
        colorsStackView.widthAnchor.constraint(equalToConstant: CGFloat(width) + spacing).isActive = true
        
        if !isColorsAdded {
            isColorsAdded = true
            
            ///Adding views dynamically in stackview
            for index in 0..<self.viewModel.exteriorColors.count {
                let view = UIView(frame: CGRect(x: 0, y: 0, width: colorWidthHeight, height: colorWidthHeight))
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = self.viewModel.exteriorColors[index]
                view.layer.cornerRadius = colorWidthHeight / 2
                colorsStackView.addArrangedSubview(view)
            }
        }
    }
    
    
    /// This methods rounds the selcetd slider value to nearest possible interval
    /// - Parameters:
    ///   - value: selected value of slider
    ///   - interval: slider interval value like 3,6,9
    /// - Returns: return new value which is nearet to selected value
    private func roundToNearestInterval(_ value: Float, interval: Float) -> Float {
        let remainder = value.truncatingRemainder(dividingBy: interval)
        let shouldRoundUp = remainder >= sliderInterval / 2
        let roundedValue = shouldRoundUp ? value + (sliderInterval - remainder) : value - remainder
        if roundedValue < 3 {
            setContractLengthAndPrice(value: 1)
            return 1.0
        } else {
            setContractLengthAndPrice(value: Int(roundedValue))
            return roundedValue
        }
    }
}
