
ns topic-tag.component.profile $ :require
  [] hsl.core :refer $ [] hsl
  [] topic-tag.style.widget :as widget
  [] respo.alias :refer $ [] create-comp div span input button img

defn init-state (user)
  {}
    :name $ :name user
    :avatar $ :avatar user
    :password $ :password user

defn update-state (state data-path value)
  assoc state data-path value

defn handle-input (mutate field-key)
  fn (simple-event dispatch)
    mutate field-key $ :value simple-event

defn handle-update (state)
  fn (simple-event dispatch)
    dispatch :user/update state

defn render-field
  mutate field-key field-value guide
  div ({} :style widget/field-line)
    div ({} :style widget/field-guide)
      span $ {} :attrs ({} :inner-text guide)

    input $ {} :style widget/textbox :attrs ({} :value field-value)
      , :event
      {} :input $ handle-input mutate field-key

defn render (user)
  fn (state mutate)
    div
      {} :style $ {} (:width |400px)
        :min-height |400px
        :background-color |white
        :border $ str "|1px solid "
          hsl 0 0 80

      render-field mutate :name (:name state)
        , |Name:
      render-field mutate :avatar (:avatar state)
        , |Avatar:
      div
        {} :style $ {} (:padding "|8px 16px")
        img $ {} :style
          {} (:width |40px)
            :height |40px
          , :attrs
          {} :src $ :avatar state

      render-field mutate :password (:password state)
        , |Password:
      div
        {} :style $ {} (:padding "|0 16px")
          :text-align |right
        button $ {} :style widget/button :event
          {} :click $ handle-update state
          , :attrs
          {} :inner-text |Update

def component-profile $ create-comp :profile init-state update-state render
