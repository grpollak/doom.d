(defun label-images-by-score-improved ()
  "Prompt the user to label an image and rename it."
  (interactive)
  (let
      (
       (regex "^(?!.*_score[0-9]+\\.([a-zA-Z0-9]+)$).*\\.([a-zA-Z0-9]+)$")
       ;; Get list of filenames "directory" <include directories>
       (image-files (directory-files "." t))
       ;; (current-index 0)
       ;; (total-images 0)
       )
    ;; (dolist (image-file image-files)
    ;;   (when (file-regular-p image-file)
    ;;     (setq total-images (1+ total-images))))
    ;; Loop over filenames
    (message "The length of image-files is %d" (length image-files))
    (dolist (image-file image-files)
      (when (file-regular-p image-file)
        ;; (setq current-index (1+ current-index))
        (let ((image (create-image image-file)))
          ;; Create new buffer
          (switch-to-buffer (generate-new-buffer "Image"))
          ;; Open Image in the new buffer
          (insert-image image)
          ;; TODO
          (fit-window-to-buffer)
          (let ((input nil))
            (while (not (memq input '(?1 ?2 ?3 ?4 ?5 ?q)))
              (setq input (read-char-exclusive "Input image (1-5, q to quit): "))
              (if (eq input ?q)
                  (progn
                    (kill-buffer)
                    (error "User quit the function.")))
              (unless (memq input '(?1 ?2 ?3 ?4 ?5))
                (message "Invalid input, please enter a number between 1 and 5 or q to quit."))))
          (when (not (eq input ?q))
            (rename-file image-file (concat (file-name-sans-extension image-file) "_score" (char-to-string input) ".jpg")))
          (kill-buffer)
          ;; (message "Labeled %d of %d images." current-index total-images)
          )))))

(provide 'label-images-by-score)
