;;; lisp/mode.el -*- lexical-binding: t; -*-
(define-derived-mode label-images-by-score-mode image-mode "Label Images By Score"
  "Major mode for labeling images by score.
\\{label-images-by-score-mode-map}"
  (defvar image-files nil "Will contain the list of image filepaths.")
  (defvar regex nil)
  (defvar index 0)
  (defvar total nil)
  (defvar input nil)

  (setq-local image-files (directory-files "/home/pollakg/poly/data/vecteezy/" t "\\(\\.jpe?g\\|\\.png\\)$")
              ;; regex "^(?!.*_score[0-9]+\\.([a-zA-Z0-9]+)$).*\\.([a-zA-Z0-9]+)$"
              index 0
              total (length image-files))
  ;; (evil-mode 0)
  (defun label-images-by-score-show-image ()
    "Show the current image."
    (let* ((image-file (nth index image-files))
           (image (create-image image-file))
           (buffer (get-buffer-create "*Label Images By Score*")))
      (with-current-buffer buffer
        (image-mode))
      (message "index: %s, total: %s, image-file: %s" index total image-file)
      (switch-to-buffer buffer)
      (erase-buffer)
      (insert-image image)
      (fit-window-to-buffer)))


  (defun label-images-by-score-rename-image (score)
    "Rename the current image with the specified score."
    (let* ((image-file (nth index image-files))
           (new-image-file (concat (file-name-sans-extension image-file) "_score" (int-to-string score) ".jpg")))
      (rename-file image-file new-image-file)
      (message "Renamed image to %s" new-image-file)
      (setq index (1+ index))
      ;; Label Images by Score
      (label-images-by-score-show-image)))

  (defun label-images-by-score-prev ()
    "Navigate to the previous image."
    (interactive)
    (setq index (max 0 (1- index)))
    (label-images-by-score-show-image))


  (defun label-images-by-score-next ()
    "Navigate to the next image."
    (interactive)
    (setq index (min (1- total) (1+ index)))
    (label-images-by-score-show-image))

  (defun label-images-by-score-score1 ()
    "Label the current image as score 1."
    (interactive)
    (label-images-by-score-rename-image 1))

  (defun label-images-by-score-score3 ()
    "Label the current image as score 3."
    (interactive)
    (label-images-by-score-rename-image 3))

  (defun label-images-by-score-score4 ()
    "Label the current image as score 4."
    (interactive)
    (label-images-by-score-rename-image 4))

  (defun label-images-by-score-score5 ()
    "Label the current image as score 5."
    (interactive)
    (label-images-by-score-rename-image 5))

  (defun label-images-by-score-quit ()
    "Quit the label images by score mode."
    (interactive)
    (quit-window)
    ;; (evil-mode 1)
    (kill-buffer))

  (label-images-by-score-show-image)
  ;; (define-keymap label-images-by-score-mode-map
  ;;   "Keymap for `label-images-by-score-mode'.")
  ;; (setq-local overriding-local-map label-images-by-score-mode-map)
  ;; Keybinginds
  ;; (use-local-map (make-sparse-keymap))
  ;; (define-key label-images-by-score-mode-map (kbd "n") 'label-images-by-score-next)
  ;; (define-key label-images-by-score-mode-map (kbd "p") 'label-images-by-score-prev)
  ;; (define-key label-images-by-score-mode-map (kbd "1") 'label-images-by-score-score1)
  ;; (define-key label-images-by-score-mode-map (kbd "2") 'label-images-by-score-score2)
  ;; (define-key label-images-by-score-mode-map (kbd "3") 'label-images-by-score-score3)
  ;; (define-key label-images-by-score-mode-map (kbd "4") 'label-images-by-score-score4)
  ;; (define-key label-images-by-score-mode-map (kbd "5") 'label-images-by-score-score5)
  ;; (define-key label-images-by-score-mode-map (kbd "q") 'label-images-by-score-quit)
  ;; Disable Evil mode
  )

(provide 'label-images-by-score-mode)
