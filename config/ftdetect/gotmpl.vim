autocmd BufNewFile,BufRead * if search('{{.\+}}', 'nw') | setlocal filetype=gohtmltmpl | endif
