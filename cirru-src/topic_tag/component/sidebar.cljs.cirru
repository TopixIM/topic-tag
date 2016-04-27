
ns topic-tag.component.sidebar $ :require
  [] respo.alias :refer $ [] create-comp div span

def style-root $ {}

def style-entry $ {} (:font-size |24px)
  :font-family |Optima

defn render (router)
  fn (state mutate)
    div ({} :style style-root)
      div ({} :style style-entry)
        span $ {} :attrs ({} :inner-text |Tags)

      div ({} :style style-entry)
        span $ {} :attrs ({} :inner-text |Topics)

def component-sidebar $ create-comp :sidebar render
