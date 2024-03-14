;; Done
(module sim-event-queue racket
  (provide
   sim-add-event
   )

  (require "sim-event.rkt")

  ;; This is a sort of "priority queue"
  ;; in O(nlog(n))
  (define (sim-add-event sim-event-queue ev ) ; Returns a new list of events which are:
    (raise 'sim-add-event)) ; sorted in asc time, etc etc (on the spec)
  )