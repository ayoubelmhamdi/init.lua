return {
    'dpayne/CodeGPT.nvim',
    cmd = 'Chat',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
    },
    config = function()
        require('codegpt.config')

        vim.g['codegpt_openai_api_key'] = os.getenv('OPENAI_API_KEY')
        vim.g['codegpt_commands'] = {
            ['doc'] = {
                system_message_template = 'You are {{language}} developer.',
                language_instructions = {
                    python = 'Use the Google style docstrings.',
                },
                max_tokens = 1024,
            },
            ----
            ['code_edit'] = {
                system_message_template = 'You are {{language}} developer.',
                user_message_template = 'I have the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\nEdit the above code. {{language_instructions}}',
                callback_type = 'code_popup',
            },
            ----
            ['modernize'] = {
                system_message_template = 'You are {{language}} developer.',
                user_message_template = 'I have the following {{language}} code: ```{{filetype}}\n{{text_selection}}```\nModernize the above code. Use current best practices. Only return the code snippet and comments. {{language_instructions}}',
                language_instructions = {
                    cpp = 'Use modern C++ syntax. Use auto where possible. Do not import std. Use trailing return type. Use the c++11, c++14, c++17, and c++20 standards where applicable.',
                },
            },
        }
    end,
}
