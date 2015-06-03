#lang racket
;; Luke Miles, June 2015

;; -------------------------------------------------------------------
;; list operations

(define (zip lists)
  (apply map list lists))

;; splits a list ls into k non-empty & disjoint sublists
(define (split-into ls k)
  (define size (quotient (length ls) k))
  (let R ([ls ls] [k k])
    (if (= k 1)
      (list ls)
      (let-values ([(soon later) (split-at ls size)])
        (cons soon (R later (sub1 k)))))))

;; partitions a list into sublists with equal elements under f
(define (multi-partition f ls)
  (hash-values
    (for/fold ([a-hash (make-immutable-hasheqv)])
              ([elm ls])
      (let ([f@elm (f elm)])
        (if (hash-has-key? a-hash f@elm)
          (hash-set a-hash f@elm (cons elm (hash-ref a-hash f@elm)))
          (hash-set a-hash f@elm (list elm)))))))

;; -------------------------------------------------------------------
;; spacial operations

;; given a list of d-dimensional points, return their mean
(define (mean points)
  (define length@points (length points))
  (map (λ (ls) (/ (apply + ls) length@points))
         (zip points)))

;; euclidean distance
(define (distance p1 p2)
  (sqrt (for/sum ([x1 p1] [x2 p2]) (expt (- x2 x1) 2))))

;; the closest center to point in centers
(define (closest centers point)
  (argmin (curry distance point) centers))

;; -------------------------------------------------------------------
;; core algorithm

;; returns the value x such that (f x) = x
(define (fixed-point f start [same? equal?])
  (let R ([x start])
    (let ([f@x (f x)])
      (if (same? x f@x)
        x
        (R f@x)))))

;; given a list of points and centers,
;; assign each point to the nearest center,
;; then returns the mean of each of these "clusters"
(define (make-next-centers points centers)
  (map mean (multi-partition (curry closest centers) points)))

;; divides the set S of points into k clusters
(define (cluster S k)
  (define first-centers (map mean (split-into S k)))
  (fixed-point (λ (centers) (make-next-centers S centers))
               first-centers))

(provide cluster)
;TODO: contract above
