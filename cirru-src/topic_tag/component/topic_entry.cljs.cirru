
ns topic-tag.component.topic-entry $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span

defn handle-click (topic)
  fn (simple-event dispatch)
    dispatch :state/route $ [] :chat-room (:id topic)

defn render (topic)
  fn (state mutate)
    div
      {} :style
        {} (:padding "|0 16px")
          :border-bottom $ str "|1px solid "
            hsl 0 0 90
          :line-height 2
          :cursor |pointer

        , :event
        {} :click $ handle-click topic

      span $ {} :attrs
        {} :inner-text $ :text topic

def component-topic-entry $ create-comp :topic-entry render
