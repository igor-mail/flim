; *** Header ***
(provide 'ew-parse)
(require 'ew-data)
(require 'lr-driver)

; *** Token Definitions ***
(defconst ew:*eoi*	0)
(defconst ew:*anchor*	1)
(defconst ew:*err*	2)
(defconst ew:tag-mailbox	3)
(defconst ew:tag-mailbox*	4)
(defconst ew:tag-mailbox+	5)
(defconst ew:tag-address*	6)
(defconst ew:tag-address+	7)
(defconst ew:tag-phrase*	8)
(defconst ew:tag-phrase-msg-id*	9)
(defconst ew:lt	10)
(defconst ew:gt	11)
(defconst ew:at	12)
(defconst ew:comma	13)
(defconst ew:semicolon	14)
(defconst ew:colon	15)
(defconst ew:dot	16)
(defconst ew:atom	17)
(defconst ew:slash	18)
(defconst ew:question	19)
(defconst ew:equal	20)
(defconst ew:token	21)
(defconst ew:qs-begin	22)
(defconst ew:qs-end	23)
(defconst ew:qs-texts	24)
(defconst ew:qs-wsp	25)
(defconst ew:qs-fold	26)
(defconst ew:qs-qfold	27)
(defconst ew:qs-qpair	28)
(defconst ew:dl-begin	29)
(defconst ew:dl-end	30)
(defconst ew:dl-texts	31)
(defconst ew:dl-wsp	32)
(defconst ew:dl-fold	33)
(defconst ew:dl-qfold	34)
(defconst ew:dl-qpair	35)
(defconst ew:cm-begin	36)
(defconst ew:cm-end	37)
(defconst ew:cm-nested-begin	38)
(defconst ew:cm-nested-end	39)
(defconst ew:cm-texts	40)
(defconst ew:cm-wsp	41)
(defconst ew:cm-fold	42)
(defconst ew:cm-qfold	43)
(defconst ew:cm-qpair	44)
(defconst ew:wsp	45)
(defconst ew:fold	46)
(defconst ew:us-texts	47)
(defconst ew:us-wsp	48)
(defconst ew:us-fold	49)
(defconst ew:n-body	50)

(defconst ew:token-defs
  (list 
   (cons 0 "*eoi*")
   (cons 1 "*anchor*")
   (cons 2 "*err*")
   (cons 3 "tag-mailbox")
   (cons 4 "tag-mailbox*")
   (cons 5 "tag-mailbox+")
   (cons 6 "tag-address*")
   (cons 7 "tag-address+")
   (cons 8 "tag-phrase*")
   (cons 9 "tag-phrase-msg-id*")
   (cons 10 "lt")
   (cons 11 "gt")
   (cons 12 "at")
   (cons 13 "comma")
   (cons 14 "semicolon")
   (cons 15 "colon")
   (cons 16 "dot")
   (cons 17 "atom")
   (cons 18 "slash")
   (cons 19 "question")
   (cons 20 "equal")
   (cons 21 "token")
   (cons 22 "qs-begin")
   (cons 23 "qs-end")
   (cons 24 "qs-texts")
   (cons 25 "qs-wsp")
   (cons 26 "qs-fold")
   (cons 27 "qs-qfold")
   (cons 28 "qs-qpair")
   (cons 29 "dl-begin")
   (cons 30 "dl-end")
   (cons 31 "dl-texts")
   (cons 32 "dl-wsp")
   (cons 33 "dl-fold")
   (cons 34 "dl-qfold")
   (cons 35 "dl-qpair")
   (cons 36 "cm-begin")
   (cons 37 "cm-end")
   (cons 38 "cm-nested-begin")
   (cons 39 "cm-nested-end")
   (cons 40 "cm-texts")
   (cons 41 "cm-wsp")
   (cons 42 "cm-fold")
   (cons 43 "cm-qfold")
   (cons 44 "cm-qpair")
   (cons 45 "wsp")
   (cons 46 "fold")
   (cons 47 "us-texts")
   (cons 48 "us-wsp")
   (cons 49 "us-fold")
   (cons 50 "n-body")
  ))

; *** Action Table ***
(defconst ew:action-table
  [
     ((default . *error*) (3 . 7) (4 . 6) (5 . 5) (6 . 4) (7 . 3) (8 . 2) (9 . 1))
     ((default . -61))
     ((default . -61))
     ((default . -61))
     ((default . -61))
     ((default . -61))
     ((default . -61))
     ((default . -61))
     ((default . *error*) (0 . 16))
     ((default . -51) (17 . 21) (22 . 20) (36 . 19) (45 . 18) (46 . 17))
     ((default . -53) (17 . 21) (22 . 20) (36 . 19) (45 . 18) (46 . 17))
     ((default . *error*) (10 . 34) (17 . 21) (22 . 20) (36 . 19) (45 . 18) (46 . 17))
     ((default . -9) (10 . 34) (17 . 21) (22 . 20) (36 . 19) (45 . 18) (46 . 17))
     ((default . *error*) (10 . 34) (17 . 21) (22 . 20) (36 . 19) (45 . 18) (46 . 17))
     ((default . -30) (10 . 34) (17 . 21) (22 . 20) (36 . 19) (45 . 18) (46 . 17))
     ((default . *error*) (10 . 34) (17 . 21) (22 . 20) (36 . 19) (45 . 18) (46 . 17))
     ((default . -1) (0 . accept))
     ((default . -63))
     ((default . -62))
     ((default . -90))
     ((default . -76))
     ((default . -61))
     ((default . -64))
     ((default . -61))
     ((default . -48))
     ((default . -49))
     ((default . -8) (10 . 34))
     ((default . -57))
     ((default . -37))
     ((default . -36) (17 . 21) (22 . 20))
     ((default . -52))
     ((default . -54) (13 . 60))
     ((default . -7))
     ((default . -55))
     ((default . -61))
     ((default . -43) (12 . 63))
     ((default . -37) (16 . -25) (12 . -25))
     ((default . -29))
     ((default . *error*) (10 . 34) (15 . 68))
     ((default . -13))
     ((default . *error*) (12 . 63) (16 . 71))
     ((default . -14))
     ((default . -27))
     ((default . -11))
     ((default . -6) (13 . 60))
     ((default . -10) (13 . 60))
     ((default . -5))
     ((default . *error*) (10 . 34))
     ((default . -4) (13 . 60))
     ((default . -32))
     ((default . -31) (13 . 60))
     ((default . -3))
     ((default . -2))
     ((default . *error*) (37 . 83) (38 . 82) (39 . 81) (40 . 80) (41 . 79) (42 . 78) (43 . 77) (44 . 76))
     ((default . *error*) (23 . 89) (24 . 88) (25 . 87) (26 . 86) (27 . 85) (28 . 84))
     ((default . -74) (36 . 19) (45 . 18) (46 . 17))
     ((default . -72) (36 . 19) (45 . 18) (46 . 17))
     ((default . *error*) (17 . 21) (22 . 20))
     ((default . -51) (17 . 21) (22 . 20))
     ((default . -38))
     ((default . -61))
     ((default . *error*) (17 . 21) (22 . 20))
     ((default . -65) (36 . 19) (45 . 18) (46 . 17))
     ((default . -61))
     ((default . *error*) (17 . 21) (29 . 96))
     ((default . *error*) (17 . 21) (22 . 20))
     ((default . *error*) (13 . 60) (15 . 68))
     ((default . -44))
     ((default . -61))
     ((default . -30) (10 . 34) (17 . 21) (22 . 20))
     ((default . -28))
     ((default . -61))
     ((default . *error*) (17 . 21) (22 . 20))
     ((default . *error*) (17 . 21) (29 . 96))
     ((default . *error*) (10 . 34) (17 . 21) (22 . 20))
     ((default . *error*) (10 . 34) (17 . 21) (22 . 20))
     ((default . -97))
     ((default . -96))
     ((default . -95))
     ((default . -94))
     ((default . -93))
     ((default . -92))
     ((default . -91))
     ((default . -89))
     ((default . -81))
     ((default . -80))
     ((default . -79))
     ((default . -78))
     ((default . -77))
     ((default . -75))
     ((default . -25))
     ((default . *error*) (11 . 113))
     ((default . -58))
     ((default . -68) (36 . 19) (45 . 18) (46 . 17))
     ((default . -56))
     ((default . -67) (36 . 19) (45 . 18) (46 . 17))
     ((default . -83))
     ((default . -61))
     ((default . -21))
     ((default . -46))
     ((default . -19))
     ((default . -45))
     ((default . -40) (16 . 71))
     ((default . *error*) (11 . 113))
     ((default . -39))
     ((default . *error*) (12 . 63))
     ((default . -70) (36 . 19) (45 . 18) (46 . 17))
     ((default . *error*) (14 . 120))
     ((default . -71) (36 . 19) (45 . 18) (46 . 17))
     ((default . -26))
     ((default . -15) (16 . 71))
     ((default . -12))
     ((default . -33))
     ((default . -61))
     ((default . -35))
     ((default . *error*) (30 . 128) (31 . 127) (32 . 126) (33 . 125) (34 . 124) (35 . 123))
     ((default . -73) (36 . 19) (45 . 18) (46 . 17))
     ((default . *error*) (17 . 21) (29 . 96))
     ((default . -42))
     ((default . *error*) (17 . 21) (29 . 96))
     ((default . -61))
     ((default . -22))
     ((default . -66) (36 . 19) (45 . 18) (46 . 17))
     ((default . -88))
     ((default . -87))
     ((default . -86))
     ((default . -85))
     ((default . -84))
     ((default . -82))
     ((default . -20))
     ((default . -41) (16 . 71))
     ((default . -69) (36 . 19) (45 . 18) (46 . 17))
    ])

; *** Goto Table ***
(defconst ew:goto-table
  [
     ((1 . 8))
     ((33 . 9))
     ((33 . 10))
     ((33 . 11))
     ((33 . 12))
     ((33 . 13))
     ((33 . 14))
     ((33 . 15))
     ()
     ((48 . 22)(44 . 23)(43 . 24)(41 . 25)(31 . 26)(28 . 27)(26 . 28)(19 . 29)(18 . 30))
     ((48 . 22)(44 . 23)(43 . 24)(41 . 25)(30 . 31)(29 . 32)(26 . 28)(19 . 29)(18 . 33))
     ((48 . 22)(44 . 23)(43 . 24)(41 . 25)(34 . 35)(26 . 36)(22 . 37)(19 . 29)(18 . 38)(13 . 39)(12 . 40)(10 . 41)(5 . 42)(4 . 43)(3 . 44))
     ((48 . 22)(44 . 23)(43 . 24)(41 . 25)(34 . 35)(26 . 36)(22 . 37)(19 . 29)(18 . 38)(13 . 39)(12 . 40)(10 . 41)(5 . 42)(4 . 43)(3 . 45)(2 . 46))
     ((48 . 22)(44 . 23)(43 . 24)(41 . 25)(34 . 35)(26 . 36)(22 . 37)(19 . 29)(18 . 47)(15 . 48)(13 . 49)(12 . 40)(5 . 42))
     ((48 . 22)(44 . 23)(43 . 24)(41 . 25)(34 . 35)(26 . 36)(22 . 37)(19 . 29)(18 . 47)(15 . 50)(14 . 51)(13 . 49)(12 . 40)(5 . 42))
     ((48 . 22)(44 . 23)(43 . 24)(41 . 25)(34 . 35)(26 . 36)(22 . 37)(19 . 29)(18 . 47)(13 . 52)(12 . 40)(5 . 42))
     ()
     ()
     ()
     ((49 . 53))
     ((45 . 54))
     ((33 . 55))
     ()
     ((33 . 56))
     ()
     ()
     ((34 . 57)(17 . 58))
     ()
     ()
     ((44 . 23)(43 . 24)(41 . 25)(26 . 59))
     ()
     ((37 . 61))
     ()
     ()
     ((33 . 62))
     ((36 . 64)(23 . 65)(21 . 66)(20 . 67))
     ()
     ()
     ((39 . 69)(34 . 35)(22 . 70))
     ()
     ((40 . 72)(36 . 73))
     ()
     ()
     ()
     ((37 . 74))
     ((37 . 74))
     ()
     ((34 . 35)(22 . 70))
     ((37 . 75))
     ()
     ((37 . 75))
     ()
     ()
     ()
     ()
     ((48 . 22))
     ((48 . 22))
     ((44 . 23)(43 . 24)(41 . 25)(26 . 90)(12 . 40)(5 . 91))
     ((44 . 23)(43 . 24)(41 . 25)(28 . 92)(26 . 28)(19 . 29)(18 . 30))
     ()
     ((33 . 93))
     ((44 . 23)(43 . 24)(41 . 25)(26 . 28)(19 . 29)(18 . 94))
     ((48 . 22))
     ((33 . 95))
     ((46 . 97)(43 . 98)(42 . 99)(24 . 100)(9 . 101)(8 . 102))
     ((44 . 23)(43 . 24)(41 . 25)(26 . 90)(12 . 40)(5 . 103))
     ((39 . 104)(37 . 105))
     ()
     ((33 . 106))
     ((44 . 23)(43 . 24)(41 . 25)(34 . 35)(26 . 36)(22 . 37)(19 . 29)(18 . 47)(15 . 50)(14 . 107)(13 . 49)(12 . 40)(5 . 42))
     ()
     ((33 . 108))
     ((44 . 23)(43 . 24)(41 . 25)(26 . 109))
     ((46 . 97)(43 . 98)(42 . 99)(24 . 100)(9 . 101)(8 . 110))
     ((44 . 23)(43 . 24)(41 . 25)(34 . 35)(26 . 36)(22 . 37)(19 . 29)(18 . 38)(13 . 39)(12 . 40)(10 . 41)(5 . 42)(4 . 111))
     ((44 . 23)(43 . 24)(41 . 25)(34 . 35)(26 . 36)(22 . 37)(19 . 29)(18 . 47)(13 . 112)(12 . 40)(5 . 42))
     ()
     ()
     ()
     ()
     ()
     ()
     ()
     ()
     ()
     ()
     ()
     ()
     ()
     ()
     ()
     ((35 . 114))
     ()
     ((48 . 22))
     ()
     ((48 . 22))
     ((47 . 115))
     ((33 . 116))
     ()
     ()
     ()
     ()
     ((40 . 117))
     ((35 . 118))
     ()
     ((36 . 119))
     ((48 . 22))
     ((38 . 121))
     ((48 . 22))
     ()
     ((40 . 117))
     ()
     ()
     ((33 . 122))
     ()
     ()
     ((48 . 22))
     ((46 . 97)(43 . 98)(42 . 99)(24 . 129)(9 . 101))
     ()
     ((46 . 97)(43 . 98)(42 . 99)(24 . 100)(9 . 101)(8 . 130))
     ((33 . 131))
     ()
     ((48 . 22))
     ()
     ()
     ()
     ()
     ()
     ()
     ()
     ((40 . 117))
     ((48 . 22))
    ])

; *** Reduction Table ***
(defconst ew:reduction-table
  (vector
    '()
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (accept $1)))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 1 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 1 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 1 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 1 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 1 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 1 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 1 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* ()
          (lr-push stack (- sp 0) 2 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 2 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 3 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 3 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 4 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 4 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 5 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 6 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($4 (aref stack (- sp 1)))
             ($3 (aref stack (- sp 3)))
             ($2 (aref stack (- sp 5)))
             ($1 (aref stack (- sp 7))))
          (lr-push stack (- sp 8) 7 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 7 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 8 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 8 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 9 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($4 (aref stack (- sp 1)))
             ($3 (aref stack (- sp 3)))
             ($2 (aref stack (- sp 5)))
             ($1 (aref stack (- sp 7))))
          (lr-push stack (- sp 8) 10 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 11 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($5 (aref stack (- sp 1)))
             ($4 (aref stack (- sp 3)))
             ($3 (aref stack (- sp 5)))
             ($2 (aref stack (- sp 7)))
             ($1 (aref stack (- sp 9))))
          (lr-push stack (- sp 10) 11 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 12 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 12 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 13 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 13 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 13 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* ()
          (lr-push stack (- sp 0) 14 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 14 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 15 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 15 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 16 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 17 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 18 goto-table (ew-mark-phrase $1 $look))))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 19 goto-table $1)))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 19 goto-table $1)))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 20 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 21 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($4 (aref stack (- sp 1)))
             ($3 (aref stack (- sp 3)))
             ($2 (aref stack (- sp 5)))
             ($1 (aref stack (- sp 7))))
          (lr-push stack (- sp 8) 21 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($4 (aref stack (- sp 1)))
             ($3 (aref stack (- sp 3)))
             ($2 (aref stack (- sp 5)))
             ($1 (aref stack (- sp 7))))
          (lr-push stack (- sp 8) 22 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* ()
          (lr-push stack (- sp 0) 23 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 23 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 24 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 24 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 25 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 26 goto-table $1)))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 26 goto-table $1)))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 27 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* ()
          (lr-push stack (- sp 0) 28 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 28 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* ()
          (lr-push stack (- sp 0) 29 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 29 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 30 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 30 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 31 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 31 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($1 (aref stack (- sp 1))))
          (lr-push stack (- sp 2) 32 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 32 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* ()
          (lr-push stack (- sp 0) 33 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 33 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 33 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 33 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 34 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 35 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 36 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 37 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 38 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 39 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 40 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 41 goto-table $1)))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 42 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 43 goto-table $1)))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 44 goto-table $1)))
    (lambda (stack sp goto-table $look)
      (let* ()
          (lr-push stack (- sp 0) 45 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 45 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 45 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 45 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 45 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 45 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 46 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* ()
          (lr-push stack (- sp 0) 47 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 47 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 47 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 47 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 47 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 47 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($3 (aref stack (- sp 1)))
             ($2 (aref stack (- sp 3)))
             ($1 (aref stack (- sp 5))))
          (lr-push stack (- sp 6) 48 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* ()
          (lr-push stack (- sp 0) 49 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 49 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 49 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 49 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 49 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 49 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 49 goto-table ())))
    (lambda (stack sp goto-table $look)
      (let* (($2 (aref stack (- sp 1)))
             ($1 (aref stack (- sp 3))))
          (lr-push stack (- sp 4) 49 goto-table ())))
  ))

; *** Parser Definition ***
(defun ew-parse(scanner errorhandler)
  (lr-parse scanner errorhandler 
    ew:action-table
    ew:goto-table
    ew:reduction-table
    ew:token-defs))

; *** Footer ***
(put 'ew:cm-texts 'decode 'ew-decode-comment)
(put 'ew:cm-wsp 'decode 'ew-decode-comment)
(put 'ew:cm-fold 'decode 'ew-decode-comment)
(put 'ew:cm-qfold 'decode 'ew-decode-comment)
(put 'ew:cm-qpair 'decode 'ew-decode-comment)
(put 'ew:us-texts 'decode 'ew-decode-unstructured)
(put 'ew:us-wsp 'decode 'ew-decode-unstructured)
(put 'ew:us-fold 'decode 'ew-decode-unstructured)


