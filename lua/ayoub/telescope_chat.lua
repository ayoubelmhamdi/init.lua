local M = {}

---- TODO:  toggle between list/dictionary telescope_insert("numbers", dict=true)
----        then for dict view key in left and value in preview wndows

M.prompts = {
  [[In neovim with Lua API]],

  [[Continue la génération des texte:@@@`@@@@@@`]],
  [[<Fr-TRADUCTION>:@@@- Agir en tant que programmeur d'intelligence artificielle pour cibler les étudiants qui veulent comprendre l'apprentissage en profondeur.@@@- Traduisez ce {Texte} en Français depuis l'Arabe.@@@Le {Texte}:@@@```@@@@@@```@@@]],

  [[<FR-OUTLINE >:@@@Proposer un {outline} sur la "Définition des nodules pulmonaires", cet {outline} devrait être plus concis et précis et clair et cohérent avec la documentation.@@@@@@Structure d'un {outline} :@@@`@@@- Introduction@@@- CHAPITRE I@@@     - Sous-chapitre@@@     - ..@@@- CHAPITRE II@@@     - Sous-chapitre@@@     - ..@@@- CONCLUSION@@@`@@@votre réponse:@@@]],
  [[<FR-IMROVE-OUTLINE >@@@Améliorer mon {outline} sur "Anatomie des nodules pulmonaires", cet {outline} devrait être plus concis et précis et clair et cohérent.@@@@@@Structure de {outline} :@@@```@@@- Introduction@@@- CHAPITRE I@@@     - Sous-chapitre@@@     - ...@@@- CHAPITRE II@@@     - Sous-chapitre@@@     - ...@@@- CONCLUSION@@@```@@@mon {outline} :@@@```@@@@@@```@@@]],
  [[<Fr-COMMENTE OUTLINE >:@@@- je ne veux pas de comprendre le contenu de cet {outline}.@@@- Ce {outline} est parler sur les nodules pulmonaire.@@@- Agir en tant que un personne qui maîtrise l'anatomie.@@@- commenté cet {outline}, est ce que cet {outline} ci-dessous est clair et cohérent.@@@@@@@@@{outline}:@@@```@@@@@@```@@@]],

  [[<Fr-REWRITE+doc: >@@@- Réécrivez la phrase ci-dessous, pour la rendre plus concis et précis, plus claire et cohérente avec la documentation.@@@- Utilisez la documentation comme source d’information fiable et corrigez les erreurs éventuelles dans la phrase.@@@@@@@La phrase:@@@```@@@```@@@@@@Documentation:@@@```@@@```]],
  [[<Fr-REWRITE: >:@@@- Agir en tant que programmeur d'intelligence artificielle pour cibler les étudiants qui veulent comprendre l'apprentissage en profondeur.@@@- Réécrivez le {texte} ci-dessous, pour la rendre plus concis et précis et claire et cohérente.@@@@@@Le {text}:@@@```@@@@@@```@@@]],
  [[<EN INDEFINE REWRITE :>@@@@@@- Act as an artificial intelligence programmer, to talk about lung nodule detection by Deep-Learning using `Luna16` dataset.@@@- The text should be reliable source of information, to make it more concise and precise, clearer and consistent with this this bellow.@@@- Use indefinite phrase, Not use narrative phrases such as "the author's talk..." or "you are"@@@@@@```@@@@@@```@@@]],

  [[<Fr-IMPROVE PROMPT: >@@@{My_prompt}: "@@@-@@@Text: `here a long text...` "@@@Improve the {My_prompt}.@@@YOUR AMELIORATION OF {My_prompt}:]],
  [[<Fr-Brinstorming >:@@@Utilisez la méthode du brainstorming pour suggérer des titres comme ce {titre}:@@@Le {titre}:@@@`@@@Anatomique + nodules + pulmonaire@@@`]],
  [[<Fr-BIBTEX: >@@@- Assume that you are an expert in artificial intelligence programming.@@@- Search for the most relevant and authoritative sources for this text.@@@- Cite the sources in the text using square brackets, without changing the original content, to make this text indexed.@@@- Provide the `BibTex` format of each citation.@@@Hint: Sources can be scientific papers or books.@@@Text:@@@```@@@@@@```]],
  [[<Fr-RESULTAT EXPECTED: >@@@Queller les resulat qui vous avez attendu par cette prompt:@@@`@@@@@@`]],
}
M.numbers = { '1', '2', '3' }
M.telescope_insert = function(list_name)
  if not list_name then
    print 'no args... exit'
    return
  end
  local list = {}
  if list_name == 'prompts' then
    list = M.prompts
  elseif list_name == 'numbers' then
    list = M.numbers
  else
    print 'args not trouve... exit'
    return
  end

  local actions = require 'telescope.actions'
  local pickers = require 'telescope.pickers'
  local finders = require 'telescope.finders'
  local conf = require('telescope.config').values
  local action_state = require 'telescope.actions.state'
  local opts = {}
  pickers
    .new(opts, {
      prompt_title = 'Pick a prompt',
      finder = finders.new_table {
        results = list,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          vim.api.nvim_put({ selection[1] }, '', false, true)
        end)
        return true
      end,
    })
    :find()
end

return M
