;;Procedures needed for the following implementation:
;;	quotient
;;	remainder
;;	apply
;;	max
;;	set-difference

;;set one bit or a list of max of 0-3 bits and calculate the hexdecimal value
(define (set-bit x)
  (define (set x) (expt 2 x))
  (cond
        ((number? x) (set x))
        ((list? x) (if (duplicate? x) (panic "Do not set repeated bit") (reduce + (map set x) 0)))
        (else panic "Enter the bit or a list of bits")))

;;takes in a hexdecimal value and output in hex form
(define (hex x)
  (if (and (< x 16) (>= x 0))
	(case x
         ((10) 'a)
         ((11) 'b)
         ((12) 'c)
         ((13) 'd)
         ((14) 'e)
	 ((15) 'f)
         (else x))
  (panic "Number 0 - 15")))

(define (duplicate? x)
	(cond
		((not (list? x)) #f)
		((null? x) #f)
		((member? (car x) (cdr x)) #t)
		(else (duplicate? (cdr x)))))

(define (member? x ls)
 (cond ((null? ls) #f)
       ((= x (first ls)) #t)
       (else (member? x (rest ls)))))

;;convert to hexdecimal value
(define (hex-con x)
	(hex (set-bit x)))

(define (remove-duplicates ls)
	(cond
	  ((null? ls) '())
	  ((member? (car ls) (cdr ls)) (remove-duplicates (cdr ls)))
	  (else (cons (car ls) (remove-duplicates (cdr ls))))))

;;group a list of numbers by their quotient by 4	
(define (group-quotient ls)
	(map list (remove-duplicates (map (lambda (x) (quotient x 4)) ls))))

(define quotient-by-4 (lambda (x) (quotient x 4)))

(define remainder-by-4 (lambda (x) (remainder x 4)))

;;iterate a list of values x -> ((0) (1) (2)... (x))
(define (enum x)
  (if (= x 0)
	'((0))
	(cons (list x) (enum (- x 1)))))

;;generate a list of all bits 
(define (generate ls)
  (enum (quotient-by-4 (apply max ls))))

;;ls1 ls2 needs to be identity list; group one bit that need to be set by their quotient
(define (group ls1 ls2 x)
  (if (= (caar ls2) (quotient-by-4 x)) 
      (if (eq? ls1 ls2) 
          (append (list (append (car ls2) (list x))) (cdr ls2))
          (append (set-difference ls1 ls2) (append (list (append (car ls2) (list x))) (cdr ls2)))) 
      (group ls1 (cdr ls2) x)))

;;ls1 is the identiy list and ls2 is the list needs to be grouped; group all bits that need to be set by their quotient
(define (group-all ls1 ls2)  
  (if (null? ls2)
   ls1 
   (group-all (group ls1 ls1 (car ls2)) (cdr ls2))))
	
;;get rid of all leading quotient values in the sublist and divide all numbers by 4
(define (divide-all-by-4 ls)
  (map (lambda (x) (map remainder-by-4 x)) (map cdr ls)))

;;input is a list
(define (result ls)
	(if (null? ls) '(0) (map hex-con (divide-all-by-4 (group-all (generate ls) ls)))))

;;input is a constant
(define (result-one x)
	(map hex-con (divide-all-by-4 (group (enum (quotient-by-4 x)) (enum (quotient-by-4 x)) x))))

;;final conversion of the hex value;
(define (convert input)
  (if (number? input) (result-one input) (result input)))
