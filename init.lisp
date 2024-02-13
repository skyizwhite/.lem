(defpackage :lem-init
  (:use :cl :lem))
(in-package :lem-init)

#+lem-sdl2
(lem-sdl2:set-keyboard-layout :jis)

(define-color-theme "transparent-decaf" ()
  (:display-background-mode :dark)
  (:foreground "#cccccc")
  (:inactive-window-background nil)
  (region :foreground nil :background "#515151")
  (syntax-warning-attribute :foreground "#ff7f7b")
  (syntax-string-attribute :foreground "#beda78")
  (syntax-comment-attribute :foreground "#777777")
  (syntax-keyword-attribute :foreground "#efb3f7")
  (syntax-constant-attribute :foreground "#ffbf70")
  (syntax-function-name-attribute :foreground "#90bee1")
  (syntax-variable-attribute :foreground "#ff7f7b")
  (syntax-type-attribute :foreground "#ffd67c")
  (syntax-builtin-attribute :foreground "#bed6ff")
  (:base00 "#2d2d2d")
  (:base01 "#393939")
  (:base02 "#515151")
  (:base03 "#777777")
  (:base04 "#b4b7b4")
  (:base05 "#cccccc")
  (:base06 "#e0e0e0")
  (:base07 "#ffffff")
  (:base08 "#ff7f7b")
  (:base09 "#ffbf70")
  (:base0a "#ffd67c")
  (:base0b "#beda78")
  (:base0c "#bed6ff")
  (:base0d "#90bee1")
  (:base0e "#efb3f7")
  (:base0f "#ff93b3"))

(load-theme "transparent-decaf")

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
(setf *scroll-recenter-p* nil)
(setf (variable-value 'lem/line-numbers:line-numbers :global) t)
(setf (variable-value 'lem-lisp-mode/paren-coloring:paren-coloring :global) t)

;;; Setup Paredit
(lem:add-hook lem:*find-file-hook*
              (lambda (buffer)
                (when (eq (buffer-major-mode buffer) 'lem-lisp-mode:lisp-mode)
                  (change-buffer-mode buffer 'lem-paredit-mode:paredit-mode t))))

(define-command slime-qlot-exec (directory) ((prompt-for-directory (format nil "Project directory (~A): " (buffer-directory))))
  (let ((command (first (lem-lisp-mode/implementation::list-roswell-with-qlot-commands))))
    (when command
      (lem-lisp-mode:run-slime command :directory directory))))
