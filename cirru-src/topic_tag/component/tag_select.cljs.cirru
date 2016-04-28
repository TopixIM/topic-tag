
ns topic-tag.component.tag-select $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span

defn render (tag resolve-select)
  fn (state mutate)
    div
      {} :style $ {}
        :background-color $ hsl 200 80 80
        :color |white
        :display |inline-block
        :padding "|0px 8px"
        :margin "|0 8px 8px 0"
        :cursor |pointer
      span $ {} :attrs
        {} :inner-text $ :text tag
        , :event
        {} :click $ resolve-select tag

def component-tag-select $ create-comp :tag-select render
