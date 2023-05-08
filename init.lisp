(defpackage :lem-init
  (:use :cl :lem))
(in-package :lem-init)

;;; Key mapping
(defparameter *custom-keymap*
  '(("Return" . lem/language-mode:newline-and-indent)
    ; workaround mapping for bugs
    ("Ȭ" . lem-paredit-mode:paredit-slurp)
    ("ȝ" . lem-paredit-mode:paredit-barf)))

(loop :for (key . cmd) :in *custom-keymap*
      :do (define-key *global-keymap* key cmd))

;;; Variable config
(setf *scroll-recenter-p* t)
(setf (variable-value 'lem/line-numbers:line-numbers :global) t)
(setf (variable-value 'lem-lisp-mode/paren-coloring:paren-coloring :global) t)

;;; Setup Paredit
(lem:add-hook lem:*find-file-hook*
              (lambda (buffer)
                (when (eq (buffer-major-mode buffer) 'lem-lisp-mode:lisp-mode)
                  (change-buffer-mode buffer 'lem-paredit-mode:paredit-mode t))))
