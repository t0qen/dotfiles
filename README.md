<div align="center">

  ### 💻️ personal dotfiles
My minimal **catppuccin** rice for i3
</div>
-----
### 📷️ Screenshots
<img width="3360" height="1050" alt="image" src="https://github.com/user-attachments/assets/b50c3df1-0eb7-4e3b-a5f2-621db2e0a4ba" />

### ✏️ Included
- alacritty
- dunst
- i3
- picom
- polybar
- rofi
- vesktop

### 💾️ Use it
Two choice :
- you can either use invidually dots like only alacritty dots or others
- use the whole repo, with the nixos config and all

  
Here are the steps for each way.
#### 🅰️ Individually use dots
1. Clone the repo in your home folder.
```bash
cd ~
git clone https://github.com/t0qen/dotfiles.git
```
2. Two ways : install [stow](https://github.com/aspiers/stow/blob/master/INSTALL.md) (easier) or use mv/cp command


**With stow**
```bash
cd ~/dotfiles
# stow (the rice you wanna use)
# for example alacritty
stow alacritty
```
**Using mv**
```bash
# mv ~/dotfiles/(the rice you wanna use)/* .config/(the program)
# still for alacritty
mv ~/dotfiles/alacritty/* .config/alacritty
```
#### 🅱️ Use the whole configuration
1. Clone the repo in your home folder.
```bash
cd ~
git clone https://github.com/t0qen/dotfiles.git
```
2. Use stow or cp/mv to use my dots (see steps from the other part)
3. Use the Nixos config
> [!IMPORTANT]
> For now the config use Nixos 26.05, be really careful with other versions
```bash
sudo mv ~/dotfiles/nix/configuration.nix /etc/nixos/
sudo mv ~/dotfiles/nix/home.nix /etc/nixos/
```
4. Make configuration.nix and home.nix your
```bash
sudo nano /etc/nixos/configuration.nix
sudo nano /etc/nixos/home.nix
```
> [!TIP]
> There are several things to change, like user name, packages, hostname, etc.
5. Compile the nix config
```bash
sudo nixos-rebuild switch
```
This may take a lot of time.


6. Last step : reboot !
```bash
sudo reboot
```
