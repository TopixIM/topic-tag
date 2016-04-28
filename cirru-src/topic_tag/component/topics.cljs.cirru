
ns topic-tag.component.topics $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span button
  [] topic-tag.style.widget :as widget

defn handle-add (simple-event dispatch)
  dispatch :state/route :add-topic

defn render (topics)
  fn (state mutate)
    div
      {} :style $ {} (:width |400px)
        :min-height |400px
        :background-color $ hsl 0 0 100
      div ({} :style widget/toolbar)
        button $ {} :style widget/button :event ({} :click handle-add)
          , :attrs
          {} :inner-text "|Add topic"

def component-topics $ create-comp :topics render
