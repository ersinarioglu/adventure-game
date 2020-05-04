(define electronic-doohickey (build '(switcheroo-button electronic-doohickey)))
(define shiny-metallic-ball (build '(switcheroo-button shiny-metallic-ball)))

(set-switcheroo-instance electronic-doohickey shiny-metallic-ball)
(set-swticheroo-instance shiny-metallic-ball electronic-doohickey)

(list electronic-doohickey shiny-metallic-ball)
