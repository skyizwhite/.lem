(defpackage :lem-init
  (:use :cl :lem))
(in-package :lem-init)

#+lem-sdl2
(lem-sdl2:set-keyboard-layout :jis)

;;;; Command

(define-command slime-qlot-exec (directory)
    ((prompt-for-directory (format nil "Project directory (~A): " (buffer-directory))))
  (let ((command (first (lem-lisp-mode/implementation::list-roswell-with-qlot-commands))))
    (when command
      (lem-lisp-mode:run-slime command :directory directory))))

;;;; Key bindings

(define-keys *global-keymap*
  ("ȸ" 'scroll-up)
  ("ȏ" 'scroll-down)
  ("Ȳ" 'forward-word)
  ("ȣ" 'previous-word)
  ("C-t" 'lem-terminal/terminal-mode::terminal))

(define-keys lem-lisp-mode:*lisp-mode-keymap*
  ("C-l s" 'lem-lisp-mode:slime)
  ("C-l q" 'slime-qlot-exec)
  ("C-l r" 'lem-lisp-mode:slime-restart)
  ("C-l f" 'format-current-buffer))

(define-keys lem-paredit-mode:*paredit-mode-keymap*
  ("Ȳ" 'lem-paredit-mode:paredit-slurp)
  ("ȣ" 'lem-paredit-mode:paredit-barf))

;;;; Variable config
(setf *scroll-recenter-p* nil)
(setf (variable-value 'lem/line-numbers:line-numbers :global) t)
(setf (variable-value 'lem-lisp-mode/paren-coloring:paren-coloring :global) t)

;;;; Setup Paredit
(lem:add-hook lem:*find-file-hook*
              (lambda (buffer)
                (when (eq (buffer-major-mode buffer) 'lem-lisp-mode:lisp-mode)
                  (change-buffer-mode buffer 'lem-paredit-mode:paredit-mode t))))
