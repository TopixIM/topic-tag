
ns topic-tag.component.topics $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span

defn render (topics)
  fn (state mutate)
    div ({})
      div ({})
        span $ {}

def component-topics $ create-comp :topics render
