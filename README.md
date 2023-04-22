# nvim-soil
### Soil for a plant (UML)
*nvim-soil is a minimal plugin written in Lua for Plant UML.*

## Caveats
- `Java` and `sxiv` are required to be installed in order to use this plugin.
- `plantuml` is optional to be installed or used in jar format.
- Recommended for Plant UML syntax highlighting [nvim-whisky colorscheme](https://github.com/charkuils/nvim-whisky)
- This plugin has been developed on and for Linux following open source philosophy.

## Installation
`Vim Plug`
```vim
Plug 'charkuils/nvim-soil'

" Optional for puml syntax highlighting:
Plug 'charkuils/nvim-whisky'
```
`Packer`
```lua
use 'charkuils/nvim-soil'

-- Optional for puml syntax highlighting:
use 'charkuils/nvim-whisky'
```

## Configuration
#### This is OPTIONAL
- If `plantuml` is installed you don't need any extra set up. But if wanted to use **plantuml jar version** you can set it up.
- The default image format is **PNG**. 
- The default Plant UML **darkmode** is set to **false**. 
- Optional configuration in *init.vim* or *init.lua*:
```lua
require'soil'.setup{ 
    -- If you want to use Plant UML jar version instead of the install version
    puml_jar = "/path/to/plantuml.jar",
    
    -- If you want to customize the image showed when running this plugin
    image = {
        darkmode = false, -- Enable or disable darkmode 
        format = "png", -- Choose between png or svg
    }
}
```

## Usage
- Open any yourfile.plantuml, yourfile.pu or yourfile.puml which you want to process and use `:Soil` Neovim command line to generate and open yourfile.png with graphical output. Press `q` to quit the image viewer.
- Everytime you update a Plant UML file and run `:Soil`, you'll get an updated image.
- The generated image is saved in the same location that your Plant UML file.

## Screenshots
### Simple use

<img src="https://github.com/charkuils/img/blob/master/nvim-soil/soil2.gif?raw=true" alt="soil" style="width:1000px;"/>

**NOTE:** The colorscheme **blend** from [nvim-whisky](https://github.com/charkuils/nvim-whisky) is used in this image.
