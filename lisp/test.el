(defun label-images-by-score ()
  "Prompt the user to label an image and rename it."
  (interactive)
  ;; (regex "^(?!.*_score[0-9]+\\.([a-zA-Z0-9]+)$).*\\.([a-zA-Z0-9]+)$")
  (let ((image-files (directory-files "." t nil t))
        (index 0)
        (total (length (directory-files "." t nil t)))
        (input nil))
    (message "first we have file %s." (nth 0 image-files))
    (while (< index total)
      (let* ((image-file (nth index image-files))
             (image (create-image image-file))
             (buffer (get-buffer-create "*Image*")))


        (switch-to-buffer buffer)
        (erase-buffer)
        (insert-image image)
        (fit-window-to-buffer)

        (setq input nil)
        (while (not (memq input '(?1 ?2 ?3 ?4 ?5 ?j ?k left right ?q)))
          (setq input (read-char-exclusive "Input image (1-5 to label, j/k or left/right to navigate, q to quit): "))
          (cond
           ((eq input ?q)
            (message "Labeled %d of %d images." index total)
            (kill-buffer buffer)
            (setq index total)) ;; break the outer loop
           ((memq input '(?j))
            (setq index (min (1- total) (1+ index))))
           ((memq input '(?k))
            (setq index (max 0 (1- index))))
           ((memq input '(?1 ?2 ?3 ?4 ?5))
            (setq input (string-to-number (char-to-string input)))
            (when (and (>= input 1) (<= input 5))
              (setq new-image-file (concat (file-name-sans-extension image-file) "_score" (char-to-string input) ".jpg"))
              (rename-file image-file new-image-file)
              (message "Renamed image to %s" new-image-file)
              (setq index (1+ index))))))
        (kill-buffer buffer)))
    (message "Labeled %d of %d images." index total)))
(provide 'label-images-by-score)
