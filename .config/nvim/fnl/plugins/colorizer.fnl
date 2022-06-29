(module plugins.colorizer)

(let [(ok? colorizer) (pcall require :colorizer)]
  (when ok?
    (colorizer.setup)))
