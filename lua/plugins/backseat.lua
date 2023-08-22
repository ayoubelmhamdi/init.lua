return {
  'james1236/backseat.nvim',
  cmd = {'Backseat','BackseatAsk','BackseatClear','BackseatClearLine'},
  config = function()
    require('backseat').setup {
      openai_model_id = 'gpt-3.5-turbo', --gpt-4
    }
  end,
}
