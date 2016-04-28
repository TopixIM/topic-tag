
ns topic-tag.component.message $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div img span
  [] topic-tag.component.space :refer $ [] component-space

defn render (message)
  fn (state mutate)
    div
      {} :style $ {} (:padding "|0 16px")
        :line-height |2
        :font-size |16px
        :display |flex
        :align-items |center
        :margin-bottom |8px
      img $ {} :style
        {} (:width |32px)
          :height |32px
        , :attrs
        {} :src $ :avatar message

      component-space |16px nil
      span $ {} :attrs
        {} :inner-text $ :text message

def component-message $ create-comp :message render
