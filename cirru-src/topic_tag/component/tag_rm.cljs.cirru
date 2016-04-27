
ns topic-tag.component.tag-rm $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span
  [] topic-tag.component.space :refer $ [] component-space

defn handle-remove (tag)
  fn (simple-event dispatch)
    dispatch :user/rm-tag $ :id tag

defn render (tag)
  fn (state mutate)
    div
      {} :style $ {}
        :background-color $ hsl 240 80 70
        :color |white
        :display |inline-block
        :margin "|0 8px 8px 0"
        :padding "|0px 8px"
        :line-height 1.6
      span $ {} :style ({})
        , :attrs
        {} :inner-text $ :text tag
      component-space |8px 0
      span $ {} :style
        {} (:font-size |12px)
          :color $ hsl 0 80 70
          :cursor |pointer
        , :event
        {} :click $ handle-remove tag
        , :attrs
        {} :inner-text |rm

def component-tag-rm $ create-comp :tag-rm render
