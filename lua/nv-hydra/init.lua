local Hydra = require('hydra')

Hydra({
   hint = [[
 ^^^^^^     Move    ^^^^^^    ^^     Split         ^^^^    Size
 ^^^^^^-------------^^^^^^    ^^---------------    ^^^^-------------
 ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^    _s_: horizontally    _+_ _-_: height
 _h_ ^ ^ _l_   _H_ ^ ^ _L_    _v_: vertically      _>_ _<_: width
 ^ ^ _j_ ^ ^   ^ ^ _J_ ^ ^                         ^ _=_ ^: equalize
 focus ^^^^^^  window
 ^ ^ ^ ^ ^ ^   ^ ^ ^ ^ ^ ^    _S_: Swap   ^ ^ ^ ^    _q_
]],
   config = {
			invoke_on_body = true,
      hint = {
         border = 'rounded'
      }
   },
   mode = 'n',
   body = '<C-w>H',
   heads = {
      -- Move focus
      { 'h', '<C-w>h' },
      { 'j', '<C-w>j' },
      { 'k', '<C-w>k' },
      { 'l', '<C-w>l' },
      -- Move window -- from 'sindrets/winshift.nvim' plug
      { 'H', '<Cmd>WinShift left<CR>' },
      { 'J', '<Cmd>WinShift down<CR>' },
      { 'K', '<Cmd>WinShift up<CR>' },
      { 'L', '<Cmd>WinShift right<CR>' },
      -- Split
      { 's', '<C-w>s' },
      { 'v', '<C-w>v' },
      -- { 'q', '<Cmd>try | close | catch | endtry<CR>', { desc = 'close window' } },
      -- Size
      { '+', '<C-w>+' },
      { '-', '<C-w>-' },
      { '>', '2<C-w>>', { desc = 'increase width' } },
      { '<', '2<C-w><', { desc = 'decrease width' } },
      { '=', '<C-w>=', { desc = 'equalize'} },
      --
      -- { 'b', '<Cmd>Telescope buffers<CR>', { exit = true, desc = 'choose buffer' } },
      { 'S', '<Cmd>WinShift swap<CR>', { exit = true, desc = 'Swap buffer' } },
		  { 'q', nil,  { exit = true }},
      -- { '<Esc>', nil,  { exit = true }}
   }
})


Hydra({
   name = 'Side scroll',
	 config = {},
   mode = 'n',
   body = 'z',
   heads = {
      { 'h', '3zh' },
      { 'l', '3zl', { desc = '←/→' } },
      { 'H', 'zH' },
      { 'L', 'zL', { desc = 'half screen ←/→' } },
   }
})
