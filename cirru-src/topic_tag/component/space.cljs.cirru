
ns topic-tag.component.space $ :require
  [] respo.alias :refer $ [] create-comp div

defn render (w h)
  fn (state mutate)
    div $ {} :style
      {}
        :width $ or w |100%
        :height $ or h (|1em)
        :display $ if (some? w)
          , |inner-block |block
        :vertical-align |middle
        :flex-grow 0
        :flex-shrink 0
        :-webkit-flex-grow 0
        :-webkit-flex-shrink 0

def component-space $ create-comp :space render
