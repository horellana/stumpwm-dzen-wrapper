(in-package :stumpwm)

;; (defvar *root-window* (first (xlib:display-roots (xlib:open-display ""))))

(defvar *dzen-script* nil)

(defvar dzen-pid nil)
(defvar dzen-visible-p nil)

(defcommand show-dzen () ()
  (mode-line))

(defcommand start-dzen () ()
  (setf dzen-pid (cl-user::process-pid (run-shell-command *dzen-script*))))

(defcommand stop-dzen () ()
  (run-shell-command (format nil "pkill ~A" (file-namestring *dzen-script*)))
  (setf dzen-pid nil))

(defcommand toggle-dzen () ()
  (show-dzen)
  (if dzen-pid (stop-dzen) (start-dzen)))

