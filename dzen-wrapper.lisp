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

  )



;; (defvar *dzen-background-color* "#000")
;; (defvar *dzen-foreground-color* "#fff")
;; (defvar *dzen-timeout* 5)
;; (defvar *dzen-alignment* :left)
;; (defvar *dzen-position* :bottom)
;; (defvar *dzen-format* nil)

;; (defvar *dzen-timer* nil)

;; (defun dzen-calc-position ()
;;   (case *dzen-position*
;;     (:bottom (format nil "-y ~A" (- (xlib:screen-height *root-window*) 18)))
;;     (:top nil)))

;; (defun reserve-screen-space ()
  

;; (defun interpret-dzen-format ()
;;   (string-trim '(#\Newline)
;;                (case (first *dzen-format*)
;;                  (:exec (run-shell-command (second *dzen-format*) t))
;;                  (:func (format nil "~A" (funcall (second *dzen-format*))))
;;                  (:str (second *dzen-format*)))))

;; (defun dzen-build-config-string (&key temp)
;;   (format nil "~@[~A~] ~@[~A~] ~@[~A~] ~@[~A~]"
;;           (format nil "-p ~A" (if temp temp ""))
;;           (dzen-calc-position)
;;           (case *dzen-alignment* (:left "-ta l") (:center "-ta c") (:right "-ta r"))
;;           (when *dzen-background-color* (format nil "-bg \"~A\"" *dzen-background-color*))))


;; ;; Code from: https://github.com/acieroid/dotfiles/blob/master/stumpwm.d/dzen.lisp
;; (let (dzen-proc)
;;   (defun start-dzen ()
;;     (setf dzen-proc (sb-ext:run-program "dzen2" (split-string (dzen-build-config-string))
;;                                         :input :stream
;;                                         :wait nil
;;                                         :search t))
;;     (sb-thread:make-thread
;;      #'(lambda ()
;;          (with-open-stream (input (sb-ext:process-input dzen-proc))
;;            (loop while (sb-ext:process-alive-p dzen-proc) do
;;                 (format input (interpret-dzen-format))
;;                 (sleep *dzen-timeout*))))))
  
;;   (defun stop-dzen ()
;;     (when dzen-proc
;;       (sb-ext:process-kill dzen-proc 15)
;;       (close (sb-ext:process-input dzen-proc))
;;       (setf dzen-proc nil))))
      
;; (let (dzen-proc)
;;   (defcomman dzen () ()
;;              (setf dzen-proc (start-dzen)
