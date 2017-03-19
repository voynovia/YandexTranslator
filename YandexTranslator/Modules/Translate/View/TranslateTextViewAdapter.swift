//
//  TranslateAdapter.swift
//  YandexTranslator
//
//  Created by Igor Voynov on 03.03.17.
//  Copyright © 2017 Igor Voynov. All rights reserved.
//

import UIKit

protocol TranslateTextViewAdapterOutput {
    func sourceTextEdited(sourceText: String)
    func setSourceTextActive()
    func setSourceTextNotActive()
}

class TranslateTextViewAdapter: NSObject {
    var output: TranslateTextViewAdapterOutput?
}

extension TranslateTextViewAdapter: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        output?.setSourceTextActive()
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        output?.setSourceTextNotActive()
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if !textView.text.isEmpty && UserDefaults.standard.bool(forKey: "isSynchronous") {
            output?.sourceTextEdited(sourceText: textView.text)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if UserDefaults.standard.bool(forKey: "isUseReturn") && text == "\n" {
            textView.endEditing(true)
            if !textView.text.isEmpty {
                output?.sourceTextEdited(sourceText: textView.text)
            }
            return false
        }
        return true
    }
}
