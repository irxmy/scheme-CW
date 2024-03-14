(module sim-lane racket
  (provide lane
           lane?
           lane-id
           lane-user
           lane-bussy?
           lane->string
           lane-length
           lane-pop
           lane-queue
           ; These routines fire events
           lane-append!
           lane-pop!
           lane-bussy-set!
           )

  (require racket/match)
  (define sim-fire-event! null) ; hack to passed procedure


  
  ;; A lane (id . (user . list) 
  (define (lane id sym)
    (set! sim-fire-event! sym) ;; dirty hack
    (cons id (cons null null)))

  ;;
  (define (lane-length ln)
    (if (pair? ln)
      (length (cdr (cdr ln)))  ; Extract the queue list and calculate its length
      0))                      ; Return 0 if the lane is not properly formed
  
  (define (lane? val)  ;return true if the value represents a lane
    (raise 'lane?)
    )

  (define (lane-bussy? lane)  ;returns true if the till is busy and false if not
     (not (null? (cdr (cdr lane)))))

  (define (lane-bussy-set ln user)
    (match ln
      [(cons id (cons _ q))
       (cons id (cons user q))]))


  (define (lane-id lane)  ; returns the id
    (car lane))

  (define (lane-user val) ; return the id of the customer at the till
    (raise 'lane-user?))
    
  (define (lane-queue val) ; return the list of customers in the queue
     (if (pair? lane)
      (cdr (cdr lane))  
      '()))    

  ;; Free
  (define (lane->string ln)
    (let
        ([lane-qu-str (apply
                       string-append 
                       (map
                        (lambda (x)(format "~a:" x))
                        (lane-queue ln)))]
          )
      (format "L(~a)[~a]|<=~a"
              (lane-id ln)
              (~a
               (if (lane-bussy? ln) (lane-user ln) "None" ) #:min-width 4)
              lane-qu-str)))

  ;; Pure
  ;; Free
  (define (lane-append ln user)
    (match ln
      [(cons id (cons u q))
       (cons id (cons u (append q (list user))))]))

  ;; Free
  (define (lane-pop ln)
    (match ln
      [(cons id (cons u (cons q qs)))
       (values q
               (cons id (cons u qs)))]))


  ; IO() fires an event
  (define (lane-bussy-set! ln user)
    (let
        ([new-lane (lane-bussy-set ln user)])
      (begin       
        (if (and
             (> (lane-length new-lane) 0)  
             (not (lane-bussy? new-lane))) ;; till is free
            (begin
              (sim-fire-event! 2(first (lane-queue new-lane)) (lane-id new-lane))) ;; CHECKOUT
            (void))
        )          
      new-lane))

  ;; IO () fires an event
  (define (lane-append! ln user)
    (let
        ([new-lane (lane-append ln user)])
      (begin
        (if (and
             (= (lane-length new-lane) 1)  ;; i'm the only 
             (not (lane-bussy? new-lane))) ;; till is free
            (sim-fire-event! 2 user (lane-id new-lane)) ;; CHECKOUT
            (void))
        )          
      new-lane))
         

  ;; IO() fires an event
  (define (lane-pop! ln )
    (let*-values
        ([(user new-lane) (lane-pop ln )]
         [ (new-la2) (lane-bussy-set new-lane user)]
         )
      (begin
        (sim-fire-event! 3 user (lane-id new-la2)) ;; CHECKOUT
        new-la2)))
    
  )