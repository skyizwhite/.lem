(defpackage :lem-init
  (:use :cl :lem))
(in-package :lem-init)

;;; Key bindings
;; workaround
(define-key *global-keymap* "ȸ" 'scroll-up)         ; C-Up
(define-key *global-keymap* "ȏ" 'scroll-down)       ; C-Down
(define-key *global-keymap* "Ȳ" 'forward-word)      ; C-Right
(define-key lem-paredit-mode:*paredit-mode-keymap*
  "Ȳ" 'lem-paredit-mode:paredit-slurp)
(define-key *global-keymap* "ȣ" 'previous-word)     ; C-Left
(define-key lem-paredit-mode:*paredit-mode-keymap*
  "ȣ" 'lem-paredit-mode:paredit-barf)

;;; Variable config
(setf *scroll-recenter-p* t)
(setf (variable-value 'lem/line-numbers:line-numbers :global) t)
(setf (variable-value 'lem-lisp-mode/paren-coloring:paren-coloring :global) t)

;;; Setup Paredit
(lem:add-hook lem:*find-file-hook*
              (lambda (buffer)
                (when (eq (buffer-major-mode buffer) 'lem-lisp-mode:lisp-mode)
                  (change-buffer-mode buffer 'lem-paredit-mode:paredit-mode t))))
