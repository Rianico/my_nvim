require("leap").add_default_mappings()
-- to: s/S
-- till: x/X
-- window: gs
-- repeat: s<CR>
-- how to remap
-- vim.keymap.set({'x', 'o'}, <some-other-key>, '<Plug>(leap-forward-till)')

require("flit").setup({
	keys = { f = "f", F = "F", t = "t", T = "T" },
	-- A string like "nv", "nvo", "o", etc.
	labeled_modes = "v",
	multiline = true,
	-- Like `leap`s similar argument (call-specific overrides).
	-- E.g.: opts = { equivalence_classes = {} }
	opts = {},
})
-- jump to next <char>: f<char>, and then type `f` or `;` to repeat
-- jump to last <char>: F<char>, and then type `F` or `;` to repeat
-- jump until next <char>: t<char>, and then type `t` or `;` to repeat
-- jump last next <char>: T<char>, and then type `T` or `;` to repeat
