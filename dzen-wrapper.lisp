(in-package :stumpwm)

;; (defvar *root-window* (first (xlib:display-roots (xlib:open-display ""))))

(defvar *dzen-script* nil)

(let (dzen-pid
      dzen-visible-p)

  (defcommand show-dzen () ()
    (if dzen-visible-p
        (progn
          (resize-head 0 0 0 1366 768)
          (setf dzen-visible-p nil))
        (progn
          (resize-head 0 0 15 1366 753)
          (setf dzen-visible-p t))))

  (defcommand start-dzen () ()
    (setf dzen-pid (cl-user::process-pid (run-shell-command *dzen-script*))))

  (defcommand stop-dzen () ()
    (run-shell-command (format nil "pkill ~A" dzen-pid))
    (setf dzen-pid nil))

  (defcommand toggle-dzen () ()
    (if dzen-pid (stop-dzen) (start-dzen))
    (show-dzen)))
