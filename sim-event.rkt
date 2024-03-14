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
    (raise 'event)
    )

  ;; P: True
  (define (event? val)
    (raise 'event?))

  ;; P: valid event
  (define (event-time ev)
    (raise 'event-time))

  ;; P: valid event
  (define (event-type ev)
    (raise 'event-type))

  

  ;; P: event-params
  (define (event-params ev)
    (raise 'event-params))

  (define (event-user ev)
    (raise 'event-user))

  (define (event-lane ev)
    (raise 'event-lane))



  (require racket/dict)
  (define (event->string ev)
    (format "~a"
            (dict-ref event-dict (event-type ev))
            ))
  )