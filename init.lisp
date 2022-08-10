(defpackage :lem-custom-init
  (:use :cl :lem))
(in-package :lem-custom-init)

;;; Key mapping
(define-key *global-keymap* "Return" 'lem.language-mode:newline-and-indent)

;;; Variable config
(setf *scroll-recenter-p* nil)
(setf (variable-value 'lem.line-numbers:line-numbers :global) t)
