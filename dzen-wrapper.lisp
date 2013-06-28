(in-package :stumpwm)

(defvar *root-window* (first (xlib:display-roots (xlib:open-display ""))))

(defvar *dzen-background-color* "#000")
(defvar *dzen-foreground-color* "#fff")
(defvar *dzen-timeout* 5)
(defvar *dzen-alignment* :left)
(defvar *dzen-position* :bottom)
(defvar *dzen-format* nil)

(defvar *dzen-timer* nil)

(defun dzen-calc-position ()
  (case *dzen-position*
    (:bottom (format nil "-y ~A" (- (xlib:screen-height *root-window*) 18)))
    (:top nil)))

(defun interpret-dzen-format (fmt-list)
  (string-trim '(#\Newline)
               (case (first fmt-list)
                 (:exec (run-shell-command (second fmt-list) t))
                 (:func (format nil "~A" (funcall (second fmt-list))))
                 (:str (second fmt-list)))))

(defun dzen-build-config-string (&key temp)
  (format nil "~@[~A~] ~@[~A~] ~@[~A~] ~@[~A~]"
          (format nil "-p ~A" (if temp temp ""))
          (dzen-calc-position)
          (case *dzen-alignment* (:left "-ta l") (:center "-ta c") (:right "-ta r"))
          (when *dzen-background-color* (format nil "-bg \"~A\"" *dzen-background-color*))))

(defun start-dzen ()
  "Runs dzen2"
  (run-shell-command
   (format nil "print ~{~A ~} | dzen2 ~A"
           (remove-if #'null (mapcar #'interpret-dzen-format *dzen-format*))
           (dzen-build-config-string))))

(defun stop-dzen ()
  (run-shell-command "pkill dzen"))

(let (current-dzen
      next-dzen)
  (labels ((update-dzen ()
             (progn
               (setf next-dzen (start-dzen))
               (run-shell-command "pkill ~A"
                                  #+sbcl (sb-ext::process-pid current-dzen))
               (setf current-dzen next-dzen))))

    (defcommand dzen () ()
      "If dzen is not running this command wil start it and also set up a timer to update it,
else it will kill dzen and clean up its timer"
      (if *dzen-timer*
          (progn
            (cancel-timer *dzen-timer*)
            (setf *dzen-timer* nil)
            (run-shell-command "pkill dzen"))
          (setf *dzen-timer*
                  (run-with-timer 1 *dzen-timeout* #'update-dzen))))))

