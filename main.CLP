; Tugas Besar 2 IF3170 Inteligensi Buatan
; RAVA - HILDA - YAKOBUS

; ROOT
(defrule isHbsag 
    =>
    (printout t "HBsAg [positive/negative]? ")
    (assert (hbsag (read))))

; START OF LEFT-ROOT
(defrule isAntiHdv 
    (hbsag positive) 
    =>
    (printout t "anti-HDV [positive/negative]? ")
    (assert (anti-hdv (read))))

;; Termination Hepatitis B+D
(defrule predict-HepatitisBD
    (hbsag positive) 
    (anti-hdv positive) 
    =>
    (printout t crlf "Hasil Prediksi = Hepatitis B+D" crlf))

(defrule isAntiHbc-LeftRoot
    (hbsag positive) 
    (anti-hdv negative)
    =>
    (printout t "anti-HBc [positive/negative]? ")
    (assert (anti-hbc (read))))

;; Termination Uncertain configuration 1
(defrule predict-UncertainConfiguration1
    (hbsag positive) 
    (anti-hdv negative) 
    (anti-hbc negative)
    =>
    (printout t crlf "Hasil Prediksi = Uncertain configuration" crlf))

(defrule isAntiHbs-LeftRoot
    (hbsag positive) 
    (anti-hdv negative) 
    (anti-hbc positive)
    =>
    (printout t "anti-HBs [positive/negative]? ")
    (assert (anti-hbs (read))))

;; Termination Uncertain configuration 2
(defrule predict-UncertainConfiguration2
    (hbsag positive) 
    (anti-hdv negative) 
    (anti-hbc positive)
    (anti-hbs positive)
    =>
    (printout t crlf "Hasil Prediksi = Uncertain configuration" crlf))

(defrule isIgmAntiHbc
    (hbsag positive) 
    (anti-hdv negative) 
    (anti-hbc positive)
    (anti-hbs negative)
    =>
    (printout t "IgM anti-HBc [positive/negative]? ")
    (assert (igm-anti-hbc (read))))

;; Termination Acute Infection
(defrule predict-AcuteInfection
    (hbsag positive) 
    (anti-hdv negative) 
    (anti-hbc positive)
    (anti-hbs negative)
    (igm-anti-hbc positive)
    =>
    (printout t crlf "Hasil Prediksi = Acute Infection" crlf))

;; Termination Chronic Infection
(defrule predict-ChronicInfection
    (hbsag positive) 
    (anti-hdv negative) 
    (anti-hbc positive)
    (anti-hbs negative)
    (igm-anti-hbc negative)
    =>
    (printout t crlf "Hasil Prediksi = Chronic Infection" crlf))
; END OF LEFT-ROOT
; -------------------
; START OF RIGHT-ROOT
(defrule isAntiHbs-RightRoot
    (hbsag negative)
    =>
    (printout t "anti-HBs [positive/negative]? ")
    (assert (anti-hbs (read))))

(defrule isAntiHbc
    (hbsag negative)
    (or (anti-hbs positive) (anti-hbs negative))
    =>
    (printout t "anti-HBc [positive/negative]? ")
    (assert (anti-hbc (read))))

;; Termination Cured
(defrule predict-Cured
    (hbsag negative) 
    (anti-hbs positive)
    (anti-hbc positive)
    =>
    (printout t crlf "Hasil Prediksi = Cured" crlf))

;; Termination Vaccinated
(defrule predict-Vaccinated
    (hbsag negative) 
    (anti-hbs positive)
    (anti-hbc negative)
    =>
    (printout t crlf "Hasil Prediksi = Vaccinated" crlf))

;; Termination Unclear (possible resolved)
(defrule predict-Unclear
    (hbsag negative) 
    (anti-hbs negative)
    (anti-hbc positive)
    =>
    (printout t crlf "Hasil Prediksi = Unclear (possible resolved)" crlf))

;; Termination Unclear Healthy not vaccinated or suspicious
(defrule predict-Healthy
    (hbsag negative) 
    (anti-hbs negative)
    (anti-hbc negative)
    =>
    (printout t crlf "Hasil Prediksi = Healthy not vaccinated or suspicious" crlf))
; END OF RIGHT-ROOT
