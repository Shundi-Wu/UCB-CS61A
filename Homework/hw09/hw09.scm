(define (curry-cook formals body) 
  (if (null? formals) body (cons 'lambda (cons (cons (car formals) nil) (cons (curry-cook (cdr formals) body) nil)))
  )
)

(define (curry-consume curry args)
  (if (null? args) curry (curry-consume (curry (car args)) (cdr args)))
)

(define-macro (switch expr options)
  (switch-to-cond (list 'switch expr options)))

(define (switch-to-cond switch-expr)
  (cons 'cond
        (map (lambda (option)
               (cons (cons 'equal? (cons (car (cdr switch-expr)) (cons (car option) nil))) (cdr option)))
             (car (cdr (cdr switch-expr))))))
