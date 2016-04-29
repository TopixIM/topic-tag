
ns topic-tag.component.user $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp img span div
  [] topic-tag.component.space :refer $ [] component-space

defn render (user)
  fn (state mutate)
    div
      {} :style $ {}
        :background-color $ hsl 0 0 86
        :display |inline-block
        :padding "|4px 8px"
        :margin "|0 8px 8px 0"
      img $ {} :style
        {} (:width |32px)
          :vertical-align |middle
          :height |32px
        , :attrs
        {} :src $ :avatar user

      component-space |8px 0
      span $ {} :style
        {} (:font-size |20px)
          :vertical-align |middle
        , :attrs
        {} :inner-text $ :name user

def component-user $ create-comp :user render
