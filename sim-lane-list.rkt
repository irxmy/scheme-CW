;; done
(module sim-lane-list racket
  (provide lane-list?
           less-crowded
           )

  (require "sim-lane.rkt")

  
  
  (define (lane-list? lst) ; returns true if the value consists of a list of lanes
    (raise 'lane-list))
    
    
  ;; This is a sort of "priority queue"
  ;; in O(nlog(n))
  (define (less-crowded sim-lanes) ;returns the least crowded lane
  (if (empty? sim-lanes)
      (error "No lanes provided")
      (let loop ((remaining-lanes sim-lanes) (min-lane (car sim-lanes)))
        (cond
          [(empty? remaining-lanes) min-lane]
          [(and (pair? (car remaining-lanes))
                (pair? min-lane))
           (let ((current-lane (car remaining-lanes)))
             (if (< (lane-length current-lane) (lane-length min-lane))
                 (loop (cdr remaining-lanes) current-lane)
                 (loop (cdr remaining-lanes) min-lane)))]
          [else
           (error "Invalid lane")])))))