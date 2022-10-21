# Exam configs

Here are a few exam configs that help you getting freaking fast.

```sh
alias k=kubectl # will already be pre-configured
export do="--dry-run=client -o yaml" # g get pod x $do
export now="--force --grace-period 0" # k delete pod x $now
```

.vimrc basic configs
```sh
set tabstop=2
set expandtab
set shiftwidth=2
set hlsearch
set number
set ignorecase
```


### Stuff to look up later on

- Configure commands in pods -> `command` arguments
- Basic helm commands / crash course/ repetitions
- When to use `command` when to use `args` and which syntax do i have to use for them?
- What does delete --force --grace-period=0 mean?
- Deployments -> how to work with different kinds of rollouts etc.


# Aliases

This here is a brief collection of aliases you should configure on examination start.
This will take around 1 minute in the beginning, but will save you multiple minutes later on.

## bash.rc

```sh
alias kaf="kubectl apply -f"
alias kgpow="kubectl get pod -o wide --watch"
```

## vim.rc

```sh
set number
set cursorline
set hlsearch
set showmatch
set ignorecase
set shiftwidth=2
set tabstop=2
set autoindent
set smartindent
```
