//
//  InstructionsTableViewCell.swift
//  Cocktail-DB-HCM
//
//  Created by le.n.t.trung on 21/12/2022.
//

import UIKit
import Reusable
import RxCocoa
import RxSwift

final class InstructionsTableViewCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var instructionsHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var instructionsTextView: UITextView!
    @IBOutlet weak var showMoreImageView: UIImageView!
    
    var showMoreButtonTapped: (() -> Void)?
    
    private var textIsFullSize = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        self.selectionStyle = .none
        instructionsTextView.do {
            $0.textColor = .white
            $0.isEditable = false
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    func configureCell(instructions: String) {
        instructionsTextView.text = instructions
        reloadTextViewStatus()
    }
    
    @IBAction func didTapShowMoreButton(_ sender: Any) {
        textIsFullSize.toggle()
        reloadTextViewStatus()
        showMoreButtonTapped?()
    }
    
    private func reloadTextViewStatus() {
        instructionsHeightContraint.constant = textIsFullSize
        ? instructionsTextView.contentSize.height
        : 0
        
        showMoreImageView.image = textIsFullSize
        ? UIImage(systemName: "chevron.down")
        : UIImage(systemName: "chevron.right")
    }
}
