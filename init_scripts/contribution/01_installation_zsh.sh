#!/usr/bin/env bash

echo "execution of $@"

# install zsh
echo installation zsh
sudo apt-get update
sudo apt install -y zsh

# install oh my zsh
echo install oh my zh
git clone https://github.com/ohmyzsh/ohmyzsh.git /home/$THE_USER/.oh-my-zsh
cp /home/$THE_USER/.oh-my-zsh/templates/zshrc.zsh-template /home/$THE_USER/.zshrc
chown -R $THE_USER:$THE_USER /home/home/$THE_USER/.oh-my-zsh
chown -R $THE_USER:$THE_USER /home/$THE_USER/.zshrc

sudo chsh $THE_USER -s $(which zsh)

#extra step for rstudio
if [ "$THE_USER" == "rstudio" ]; then
echo \
    "
    setHook('rstudio.sessionInit', function(newSession) {
        if (newSession && identical(getwd(), path.expand('~')))
        {
            message('ZSH est maintenant le terminal par defaut')
            message('dev : module de formation $REPO')
            rstudioapi::writeRStudioPreference('posix_terminal_shell', 'zsh')
        }
    }, action = 'append')
    " >> /home/rstudio/.Rprofile
chown -R $THE_USER:$THE_USER /home/$THE_USER
fi

