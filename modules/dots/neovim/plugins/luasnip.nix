{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = luasnip;
  type = "lua";
  config = # lua
    ''
      --> luasnip <--
      local ls = require'luasnip'

      ls.config.setup({
          enable_autosnippets = true,
      })

      map({'i', 's'}, '<Tab>', function()
          if ls.expand_or_jumpable() then
              ls.expand_or_jump()
          else
              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
          end
      end)

      local snip = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local l = require'luasnip.extras'.lambda

      local function shell_cmd(cmd)
          local handle = io.popen(cmd)
          local result = handle:read("*a")
          handle:close()
          return result:gsub('%s+$', ''')
      end

      local function figlet(_, snippet)
          local cap_one = snippet.captures[1] or ""
          local cap_two = snippet.captures[2] or ""

          local font, text
          if cap_two ~= "" then
              font = cap_one
              text = cap_two
          else
              font = nil
              text = cap_one
          end

          if not text or text == "" then
              return "!empty input"
          end

          local cmd
          if font then
              cmd = "figlet -f " .. vim.fn.shellescape(font) .. " " .. vim.fn.shellescape(text)
          else
              cmd = "figlet " .. vim.fn.shellescape(text)
          end

          local handle = io.popen(cmd)
          if handle then
              local result = handle:read("*a")
              handle:close()
              if result then
                  local lines = {}
                  for line in result:gmatch("([^\n]*)\n") do
                      table.insert(lines, (line:gsub("%s+$", "")))
                  end
                  return lines
              end
          else
              return "!failed to run figlet"
          end
      end

      ls.add_snippets('all', {
          snip('dt', {
              f(function() return shell_cmd('date +%D') end)
          }),
          snip('date', {
              f(function() return shell_cmd('date "+%d %B, %Y"') end)
          }),
          snip({
              trig = '!fig %((.*)%)',
              regTrig = true,
          }, {
              f(figlet)
          }),
          snip({
              trig = '!fig (.*) %((.*)%)',
              regTrig = true,
          }, {
              f(figlet)
          })
      })

      ls.add_snippets('nix', {
          snip({
              trig = '^f}',
              trigEngine = 'pattern',
              snippetType = 'autosnippet'
          }, {
              t('{ '),
              i(1),
              t({'... }:', ''', '''}),
              i(0),
          }),
          snip({
              trig = 'w]',
              snippetType = 'autosnippet',
          }, {
              t('with '),
              i(1, 'pkgs'),
              t({'; [', '  '}),
              i(2),
              t({''', '];', '''}),
              i(0)
          }),
          snip({
              trig = "s'",
              snippetType = 'autosnippet',
          }, {
              t({"'''", '  '}),
              i(0),
              t({''', "''';"})
          }),
      })

      ls.add_snippets('python', {
          snip({
              trig = '^main',
              trigEngine = 'pattern',
              snippetType = 'autosnippet',
          }, {
              t({ 'def main() -> None:', '    ' }),
              i(0, '...'),
              t({ ''', ''', 'if __name__ == \'__main__\':', '    main()' }),
          }),
          snip({
              trig = 'def ',
              snippetType = 'autosnippet',
          }, {
              t('def '),
              i(1, 'fn'),
              t('('),
              i(2),
              t(') -> '),
              i(3, 'None'),
              t({':', '    '}),
              i(0, '...')
          }),
          snip({
              trig = '^class ',
              trigEngine = 'pattern',
              snippetType = 'autosnippet',
          }, {
              t('class '),
              i(1, 'Cls'),
              t({':', '    def __init__('}),
              i(2, 'self,'),
              t({'):', '       '}),
              i(0, '...')
          }),
          snip({
              trig = 'match ',
              snippetType = 'autosnippet',
          }, {
              t('match '),
              i(1),
              t({':', '    case '}),
              i(2),
              t({':', '        '}),
              i(3, '...'),
              t({''', '    case _:', '        '}),
              i(0, '...'),
          })
      })

      ls.add_snippets('rust', {
          snip({
              trig = 'fn ',
              snippetType = 'autosnippet',
          }, {
              t('fn '),
              i(1, 'name'),
              t('('),
              i(2),
              t(') -> '),
              i(3, '()'),
              t({' {', '    '}),
              i(0),
              t({''', '}'}),
          }),
          snip({
              trig = 'fnn',
              snippetType = 'autosnippet',
          }, {
              t('fn '),
              i(1, 'name'),
              t('('),
              i(2),
              t({') {', '    '}),
              i(0),
              t({''', '}'}),
          }),
          snip({
              trig = 'struct ',
              snippetType = 'autosnippet',
          }, {
              i(1, 'pub '),
              t('struct '),
              i(2, 'Name'),
              t({' {', '    '}),
              i(0),
              t({''', '}'})
          }),
          snip({
              trig = 'enum ',
              snippetType = 'autosnippet',
          }, {
              i(1, 'pub '),
              t('enum '),
              i(2, 'Name'),
              t({' {', '    '}),
              i(0),
              t({''', '}'})
          }),
      })
    '';
}
