(module event racket
  (provide event
           event?
           event-time
           event-type
           event-user
           event-lane
           event-params
           ENTER_EVENT
           CHECKOUT_EVENT
           LEAVE_EVENT
           event->string
           )

  (define ENTER_EVENT 1)
  (define CHECKOUT_EVENT 2)
  (define LEAVE_EVENT 3)

  (define event-dict
    (list (cons ENTER_EVENT "ENTER_EVENT")
          (cons CHECKOUT_EVENT "CHECKOUT_EVENT")
          (cons LEAVE_EVENT "LEAVE_EVENT")))
          

  ;; constructor.
  ;; ( time . ( id . (user . id-lane)))
  (define (event time id params)  
   (cons time (cons id params))
    )

  ;; P: True
  (define (event? val)  ;returns true if it matches the format of an event
    (raise 'event?))

  ;; P: valid-event
  (define (event-time ev) ; return the time of a given event
    (car ev))

 
  ;; P: valid event
  (define (event-type ev) ; returns the type of the event given
    (car (cdr ev)))

 
  ;; P: event-params
  (define (event-params ev) ;return the customer and lane ID as a pair
    (raise 'event-params))

  (define (event-user ev) ; returns the customer ID engaged in the event
    (car (cdr (cdr ev))))

  (define (event-lane ev) ; returns the lane ID relating to the event
    (raise 'event-lane))



  (require racket/dict)
  (define (event->string ev)
    (format "~a"
            (dict-ref event-dict (event-type ev))
            ))
  )