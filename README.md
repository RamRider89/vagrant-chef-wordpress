# vagrant-chef-apache
Apache con chef

# 1. Inicializar Vagrant
```vagrant init ubuntu/focal64```

# 1. Inicializar Chef
```mkdir cookbooks && cd cookbooks``` \n
```chef generate cookbook wordpress```

# 2. Editar receta apache```
```nano cookbooks/wordpress/recipes/default.rb```

# 3. Iniciar maquina virtual
```vagrant up```

## En caso de fallar el aprovisionamiento
```vagrant reload --provision```

## Para acceder a la maquina virtual
```vagrant ssh```

## Para detener la maquina virtual
```vagrant halt```

## Para destruir maquina virtual
```vagrant destroy```


# 4. Acceso remoto desde la red local mediante SSH
```vagrant ssh```
- se generan las claves en la maquina virtual
```ssh-keygen```


# REF
## Comandos Virtual Box
```VBoxManage list vms```
```VBoxManage list runningvms```
```VBoxManage unregistervm "name-vm" --delete```