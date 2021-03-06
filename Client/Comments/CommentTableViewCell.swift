//
//  CommentTableViewCell.swift
//  Hackers2
//
//  Created by Weiran Zhang on 07/06/2014.
//  Copyright (c) 2014 Glass Umbrella. All rights reserved.
//

import Foundation
import UIKit
import SwipeCellKit

class CommentTableViewCell : SwipeTableViewCell {
    var commentDelegate: CommentDelegate?
    
    private var level: Int = 0 {
        didSet { updateIndentPadding() }
    }
    
    private var comment: CommentModel? {
        didSet {
            guard let comment = comment else { return }
            updateCommentContent(with: comment)
        }
    }
    
    @IBOutlet var commentTextView: TouchableTextView!
    @IBOutlet var authorLabel : UILabel!
    @IBOutlet var datePostedLabel : UILabel!
    @IBOutlet var leftPaddingConstraint : NSLayoutConstraint!
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupTheming()
        contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CommentTableViewCell.cellTapped)))
    }
    
    @objc private func cellTapped() {
        commentDelegate?.commentTapped(self)
        setSelected(!isSelected, animated: false)
    }
    
    private func updateIndentPadding() {
        let levelIndent = 15
        let padding = CGFloat(levelIndent * (level + 1))
        leftPaddingConstraint.constant = padding
    }
    
    public func updateCommentContent(with comment: CommentModel) {
        let isCollapsed = comment.visibility != .visible
        level = comment.level
        authorLabel.text = comment.authorUsername
        authorLabel.font = AppFont.commentUsernameFont(collapsed: isCollapsed)
        datePostedLabel.text = comment.dateCreatedString
        datePostedLabel.font = AppFont.commentDateFont(collapsed: isCollapsed)
        
        if let commentTextView = commentTextView, comment.visibility == .visible {
            // only for expanded comments
            let commentFont = UIFont.preferredFont(forTextStyle: .subheadline)
            let commentTextColor = AppThemeProvider.shared.currentTheme.textColor
            
            let commentAttributedString = NSMutableAttributedString(string: comment.text.parsedHTML())
            let commentRange = NSMakeRange(0, commentAttributedString.length)
            
            commentAttributedString.addAttribute(NSAttributedString.Key.font, value: commentFont, range: commentRange)
            commentAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: commentTextColor, range: commentRange)
            
            commentTextView.attributedText = commentAttributedString
        }
    }
}

extension CommentTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if let commentDelegate = commentDelegate {
            commentDelegate.linkTapped(URL, sender: textView)
            return false
        }
        return true
    }
}

extension CommentTableViewCell {
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selected ? setSelectedBackground() : setUnselectedBackground()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        highlighted ? setSelectedBackground() : setUnselectedBackground()
    }
    
    private func setSelectedBackground() {
        backgroundColor = AppThemeProvider.shared.currentTheme.cellHighlightColor
    }
    
    private func setUnselectedBackground() {
        backgroundColor = AppThemeProvider.shared.currentTheme.backgroundColor
    }
}

extension CommentTableViewCell: Themed {
    func applyTheme(_ theme: AppTheme) {
        backgroundColor = theme.backgroundColor
        if commentTextView != nil {
            commentTextView.tintColor = theme.appTintColor
        }
        if authorLabel != nil {
            authorLabel.textColor = theme.titleTextColor
        }
        if datePostedLabel != nil {
            datePostedLabel.textColor = theme.lightTextColor
        }
        if separatorView != nil {
            separatorView.backgroundColor = theme.separatorColor
        }
    }
}
