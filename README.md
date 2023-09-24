# Expander

## Description

Expander is a Vim plugin for expanding newline characters inserted between
brackets, XML-like tags, and other pairs of enclosing elements.

The main goal of Expander is to be easy to use and fast.

## How to Install

There are many ways to install the plugin in Vim.

### Vim Package Feature

#### Step 1

To install the plugin using the Vim package feature, first create a new folder
inside your Vim files folder matching the pattern `pack/*/opt/<name>`, where
`<name>` is a name of your choice. In unix this can be:

```bash
mkdir -p ~/.vim/pack/plugin/opt/expander
cd ~/.vim/pack/plugin/opt/expander
git clone --depth 1 https://github.com/victorspt/expander.git .
```

In Windows this can be:

```bash
mkdir ~\vimfiles\pack\plugin\opt\expander
cd ~\vimfiles\pack\plugin\opt\expander
git clone --depth 1 https://github.com/victorspt/expander.git .
```

#### Step 2

Then add the command `packadd <name>` to your vimrc file to enable the plugin
where `<name>` is the same name you chose in the previous step. For instance in
unix this can look like:

```vim
" ~/.vimrc
packadd expander
```

And in Windows this can look like:

```vim
" ~\_vimrc
packadd expander
```

### A Vim Plugin Manager

Check with your preferred Vim plugin manager for instructions on how to install a
new plugin.

## Options

Some global variables control specific behaviors and can be changed to
customize how the plugin works.

#### `g:isExpanderEnabled`

default value: 1

Change the value to 0 to turn off the plugin. For example in the vimrc file:

```vim
" Turn off Expander:
let g:isExpanderEnabled = 0
```
