require("copilot").setup {
  server_opts_overrides = {
    trace = "verbose",
    settings = {
      advanced = {
        listCount = 10, -- #completions for panel
        inlineSuggestCount = 5, -- #completions for getCompletions
      }
    },
  }
}
