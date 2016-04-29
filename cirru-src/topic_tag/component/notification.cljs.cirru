
ns topic-tag.component.notification $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span

defn render (notification)
  fn (state mutate)
    div $ {}

def component-notification $ create-comp :notification render
