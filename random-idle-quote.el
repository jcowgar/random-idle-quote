;;; random-idle-quote.el --- Display a random quote during idle

;; Copyright (C) 2004-2020  Jeremy Cowgar <jeremy@cowgar.com>

;; Author: Jeremy Cowgar <jeremy@cowgar.com>
;; URL: https://github.com/jcowgar/random-idle-quote
;; Keywords: lisp, random, quote, learning
;; Version: 0
;; Package-Requires: ((emacs "26.1"))

;; This file is not part of GNU Emacs.

;; This is free software; you can redistribute it and/or modify it under
;; the terms of the GNU General Public License as published by the Free
;; Software Foundation; either version 2, or (at your option) any later
;; version.
;;
;; This is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
;; FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
;; for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
;; MA 02111-1307, USA.

;;; Commentary:

;; When Emacs goes into idle mode, a random quote will appear in your
;; echo window.  Use it to help me memorize keyboard shortcuts, to
;; memorize any random text you may be working on, or fill it with
;; quotes to brighten your day.

;; Quotes come pre-loaded with tips from the Emacs Wiki Page
;; http://www.emacswiki.org/cgi-bin/wiki/EmacsNiftyTricks.

;; You can customize the quotes shown by `M-X customize-group RET
;; random-idle-quotes RET`.

;; To install add:
;;
;;   (use-package 'random-idle-quote
;;     :ensure t
;;     :config
;;     (random-idle-quote-mode))
;;
;; to your ~/.emacs (or ~/.emacs.d/init.d).  When your Emacs goes into
;; idle mode, a quote will appear in your echo window.

;;; Thanks:

;; Many people on irc.freenode.net#emacs

;;; Code:

(require 'seq)

;; Customization

(defgroup random-idle-quote nil
  "Options concerning the configuration of random-idle-quote."
  :group 'random-idle-quote
  :version "1.0")

(defcustom random-idle-quote-delay 10
  "Number of seconds to display quote after Emacs enters idle mode."
  :group 'random-idle-quote
  :type 'number)

(defcustom random-idle-quotes
  '("When doing isearch, C-w adds the word following point to the search buffer. Very useful."
    "Remove trailing whitespace with delete-trailing-whitespace in Emacs 21 and later."
    "M-x auto-insert-mode -- have your files start up with a user defined template."
    "M-z zap-to-char -- Zap to the char of your choice."
    "M-/ auto-completes a word. Good for long variable names."
    "Trouble building a regex? M-x re-builder!"
    "Use isearch as a navigation mechanism."
    "For studlyCaps, use (c-subword-mode 1): makes some movements and text commands recognize case-change."
    "Learn to use M-x query-replace-regexp (C-M-%)."
    "M-x sort-lines to sort lines of text"
    "Map the CAPS LOCK key as a Control key -- One of the most important changes to be Emacs happy!"
    "M-SPC will remove all but one space!"
    "Undo with C-x u, C-/ or C-_"
    "C-h b to list all shortcuts."
    "Upper case a region with C-x C-u"
    "Align lines in a region on a common string with M-x align-regexp."
    "C-u M-! inserts the result of the shell-command directly into the buffer, quite handy for stuff like uptime, uname, etc..."
    "C-u M-| replaces the current region with the output of a shell command which gets the region passed as input. e.g. C-x h C-u M-| uniq RET can be used to apply the uniq command to the current buffer")
  "List of quotes to show during idle."
  :group 'random-idle-quote
  :type '(repeat string))

(defvar random-idle-quote--timer nil
  "Internally assigned timer to enable the cancelling of functionality.")

(defun random-idle-quote-get ()
  "Get a random quote from `random-idle-quotes'."
  (replace-regexp-in-string "%" "%%" (seq-random-elt random-idle-quotes)))

(defun random-idle-quote-show ()
  "Show a random idle quote."
  (message (format "Quote Time: %s" (random-idle-quote-get))))

(defun random-idle-quote-stop()
  "Stop showing random idle quotes."
  (interactive)
  (cancel-timer random-idle-quote--timer))

;;;###autoload
(define-minor-mode random-idle-quote-mode
  "Toggle Random Idle Quote mode.
Receive random quotes when Emacs is idle."
  :group 'random-idle-quote
  :lighter " Random Quote"
  :global t
  (setq random-idle-quote--timer
	(run-with-idle-timer random-idle-quote-delay 5 #'random-idle-quote-show)))

(provide 'random-idle-quote)

;;; random-idle-quote.el ends here
