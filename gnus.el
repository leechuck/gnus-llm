(defvar my-gnus-llm-prompt
  "Please write a response to the following email:"
  "Prompt for the LLM when generating a response to an email.")

(defun my-gnus-llm-response ()
  "Generate an LLM response to the current email in Gnus."
  (interactive)
  (let ((full-email (buffer-substring-no-properties (point-min) (point-max)))
             ;; Process the full email to remove lines starting with ">"
	(unquoted-email (with-temp-buffer
			  (insert full-email)
			  ;; Go through each line and remove ">" if present
			  (goto-char (point-min))
			  (while (not (eobp)) ; Until end of buffer
                            (when (looking-at-p "^>")
                              (delete-char 1)) ; Remove the ">" character
                            (forward-line 1)) ; Move to the next line
			  (buffer-string)))) ; Return the processed text
    (gptel-request
     (concat my-gnus-llm-prompt "\n\n" unquoted-email)
     :callback (lambda (response info)
                 (when response
		   (with-local-quit
                     (with-current-buffer (plist-get info :buffer)
;;                     (save-excursion
;;                     (goto-char (plist-get info :position))
                       (insert response)))))
     :stream t)))


(define-key message-mode-map (kbd "C-c C-r") 'my-gnus-llm-response)
