(require 'dash)
(require 'dash-functional)
(defun lean-extract-code (code)
  "Given a code, extract the main part wrapped with -- BEGIN and -- END (if any)"
  (let* ((lines (s-split "\n" code))
         (begin-marker "-- BEGIN")
         (end-marker "-- END")
         (core-lines
          (cond ((and (-contains? lines begin-marker) (-contains? lines end-marker))
                 (car (--split-when (or (s-equals? it begin-marker)
                                        (s-equals? it end-marker))
                                    (--drop-while (not (s-equals? it begin-marker)) lines))))
                (t lines)))
         (full-lines
          (--filter (and (not (s-equals? begin-marker it))
                         (not (s-equals? end-marker it)))
                    lines)))
    (cons (s-join "\n" core-lines)
          (s-join "\n" full-lines))))
(provide 'lean-export-util)
