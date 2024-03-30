(defun my-gnus-llm-response ()
  "Send the entire email to an LLM using `gptel-send` and insert the response at the top of the email."
  (interactive)
  (let ((response-separator "--text follows this line--"))
    (save-excursion
      (message-goto-body)
      (let ((email-body (buffer-substring (point) (point-max))))
        (delete-region (point) (point-max))
;;        (insert response-separator "\n\n")
        (message-goto-body)
        (gptel-send)
;;        (insert (format "Please write a response to the following email:\n\n%s\n" email-body))
	)
      )))
