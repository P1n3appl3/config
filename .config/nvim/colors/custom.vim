set background=dark
lua package.loaded['my_colors']=nil
lua require('lush')(require('my_colors'))
