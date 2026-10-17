
return {
  {
    "Saghen/blink.cmp",
    opts = {
      completion = {
        -- Borders for the main completion menu list
        menu = {
          border = "rounded",
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
        },
        -- Borders for the documentation popup that appears next to suggestions
        documentation = {
          window = {
            border = "rounded",
            winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocSelection,Search:None",
          },
        },
      },
    },
  },
}
