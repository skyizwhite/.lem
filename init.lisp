(defpackage :lem-init
  (:use :cl :lem))
(in-package :lem-init)

;;; Theme
(define-color-theme "laser-wave" ()
  (:display-background-mode :dark)
  (:inactive-window-background nil)
  (modeline :background "#404040" :foreground "white")
  (modeline-inactive :background "#303030" :foreground "gray")
  (region :foreground nil :background "#301526")
  (syntax-string-attribute :foreground "#b4dce7")
  (syntax-comment-attribute :foreground "#b4abbe")
  (syntax-keyword-attribute :foreground "#40b4c4")
  (syntax-constant-attribute :foreground "#ffe261")
  (syntax-function-name-attribute :foreground "#eb64B9")
  (syntax-variable-attribute :foreground "#ffe261")
  (syntax-type-attribute :foreground "#b381c5"))

(load-theme "laser-wave")

;;; Key mapping
(defparameter *custom-keymap*
  '(("Return" . lem.language-mode:newline-and-indent)
    ; workaround mapping for bugs
    ("Ȭ" . lem-paredit-mode:paredit-slurp)
    ("ȝ" . lem-paredit-mode:paredit-barf)))

(loop :for (key . cmd) :in *custom-keymap*
      :do (define-key *global-keymap* key cmd))

;;; Variable config
(setf *scroll-recenter-p* nil)
(setf (variable-value 'lem.line-numbers:line-numbers :global) t)
(setf (variable-value 'lem-lisp-mode.paren-coloring:paren-coloring :global) t)

;;; Setup Paredit
(lem:add-hook lem:*find-file-hook*
              (lambda (buffer)
                (when (eq (buffer-major-mode buffer) 'lem-lisp-mode:lisp-mode)
                  (change-buffer-mode buffer 'lem-paredit-mode:paredit-mode t))))
