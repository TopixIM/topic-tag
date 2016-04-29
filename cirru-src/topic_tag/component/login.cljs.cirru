
ns topic-tag.component.login $ :require
  [] hsl.core :refer $ [] hsl
  [] respo.alias :refer $ [] create-comp div span input button
  [] topic-tag.style.widget :as widget
  [] topic-tag.component.space :refer $ [] component-space

defn init-state ()
  {} :name | :password |

defn update-state
  state kind op op-data
  case kind
    :set! $ assoc state op op-data
    :clear! $ {} :name | :password |
    , state

def style-field widget/field-line

def style-guide widget/field-guide

def style-input widget/textbox

def style-button widget/button

defn handle-input (mutate state-path)
  fn (simple-event dispatch)
    mutate :set! state-path $ :value simple-event

defn handle-submit (state mutate)
  fn (simple-event dispatch)
    let
      (username $ :name state)
      if
        > (count username)
          , 2
        do (dispatch :user/enter state)
          mutate :clear!

def hint-unstable "|This app is not stable and this is running in develop mode. Crashes and refreshes frequently. Also you may talk to me on https://www.livecoding.tv/jiyinyiyong/chat"

defn render ()
  fn (state mutate)
    div
      {} :style $ {} (:width |400px)
        :background-color $ hsl 0 0 100
        :border $ str "|1px solid "
          hsl 0 0 80

      div
        {} :style $ {} (:font-family "|Helvetica Neue")
          :font-size |14px
          :text-align |center
          :line-height 2
          :font-size |24px
          :font-weight |lighter
        span $ {} :style ({})
          , :attrs
          {} $ :inner-text |Enter

      div
        {} :style $ {}
          :color $ hsl 0 0 60
          :padding "|0 16px"
          :font-size |12px
        span $ {} :attrs ({} :inner-text hint-unstable)

      div ({} :style style-field)
        div ({} :style style-guide)
          span $ {} :attrs ({} :inner-text |Name:)

        input $ {} :style style-input :attrs
          {} :value (:name state)
            , :placeholder "|a name?"
          , :event
          {} :input $ handle-input mutate :name

      div ({} :style style-field)
        div ({} :style style-guide)
          span $ {} :attrs ({} :inner-text |Password:)

        input $ {} :style style-input :attrs
          {} :value (:password state)
            , :placeholder "|this app is built for fun, so..."
          , :event
          {} :input $ handle-input mutate :password

      div
        {} :style $ {} (:display |flex)
          :justify-content |flex-end
          :padding "|8px 16px"
        button $ {} :style style-button :event
          {} :click $ handle-submit state mutate
          , :attrs
          {} :inner-text |Start

      component-space nil |40px

def component-login $ create-comp :login init-state update-state render
