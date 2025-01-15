//
//  FilterButton.swift
//  MSShopping
//
//  Created by 강민수 on 1/15/25.
//

import SnapKit
import UIKit

final class FilterButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .white : .black
        }
    }

    init(type: FilterButtonType) {
        super.init(frame: .zero)
        
        setupView(type)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView(_ type: FilterButtonType) {
        setTitle(type.title, for: .normal)
        setTitleColor(.white, for: .normal)
        setTitleColor(.black, for: .selected)
        setTitleColor(.gray, for: .highlighted)
        titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = .black
    }
}

extension FilterButton {
    
    enum FilterButtonType: Int, CaseIterable {
        case accuracy
        case date
        case highestPrice
        case lowestPrice
        
        var title: String {
            switch self {
            case .accuracy:
                return "  정확도  "
            case .date:
                return "  날짜순  "
            case .highestPrice:
                return "  가격높은순  "
            case .lowestPrice:
                return "  가격낮은순  "
            }
        }
        
        var query: String {
            switch self {
            case .accuracy:
                "sim"
            case .date:
                "date"
            case .highestPrice:
                "dsc"
            case .lowestPrice:
                "asc"
            }
        }
    }
}
