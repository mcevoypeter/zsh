export PATH="$GOBIN:$NVM_BIN:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
if [[ "$(uname -s)" == "Darwin" ]]
then
  export PATH="/opt/hombrew/bin:$PATH"
fi
