# tired of "Unable to locate package diff-so-fancy ?"
# choose a folder that is in your PATH or create a new one
mkdir -p ~/bin
# add ~/bin to your PATH (.bashrc or .zshrc)
cd ~/bin
git clone https://github.com/so-fancy/diff-so-fancy diffsofancy
chmod +x diffsofancy/diff-so-fancy
ln -s ~/bin/diffsofancy/diff-so-fancy ~/bin/diff-so-fancy
