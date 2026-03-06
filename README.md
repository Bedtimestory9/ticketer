## Install Erlang/Elixir
install Elixir/Erlang, reference: `https://elixir-lang.org/install.html`

- MacOS:
  `brew install elixir`

- Windows: download and install
1. `www.erlang.org/downloads.html`
2. click on "Download Windows installer"
3. run the Erlang installer
4. download Elixir installer: `https://github.com/elixir-lang/elixir/releases/download/v1.19.5/elixir-otp-28.exe`
5. run Elixir installer
6. check running `iex` if the command works, if not might need a restart

- or use Bash, for Windows/ MacOS /Linux

```bash
curl -fsSO https://elixir-lang.org/install.sh
sh install.sh elixir@1.19.5 otp@28.1
installs_dir=$HOME/.elixir-install/installs
export PATH=$installs_dir/otp/28.1/bin:$PATH
export PATH=$installs_dir/elixir/1.19.5-otp-28/bin:$PATH
iex
```

## Run program

clone repo: `https://gitee.com/lawrence-su_1_0/ticketer.git`

at root directory, run (bash):
```bash
mix deps.get
```

and then run

```bash
mix escript.build
```

then run 
```bash
./ticketer create "new test ticket"
```

```bash
./ticketer ls -a
```
